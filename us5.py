from common import *

us = '''
* US5: Identify and Move Inactive Channels

   As a:  Server Owner
 I want:  To automatically archive and categorize inactive channels
So That:  I can prevent overcrowding and keep active discussions accessible
'''

print(us)

def archive_inactive_channels(threshold_days=30):
    """
    Archives channels that have been inactive for a specified number of days.
    """
    cols = 'channelID, channelName, is_archived'

    # Query to find inactive channels
    find_inactive_tmpl = '''
    SELECT c.channelID, c.channelName, c.is_archived
    FROM Channel c
    LEFT JOIN Message m ON c.channelID = m.channelID
    GROUP BY c.channelID, c.channelName, c.is_archived
    HAVING MAX(m.timestamp) < (CURRENT_DATE - interval '%s days') OR MAX(m.timestamp) IS NULL;
    '''
    find_inactive_cmd = cur.mogrify(find_inactive_tmpl, (threshold_days,))
    print_cmd(find_inactive_cmd)
    cur.execute(find_inactive_cmd)
    inactive_channels = cur.fetchall()

    if not inactive_channels:
        print("No inactive channels found.")
        return

    archive_tmpl = '''
    UPDATE Channel
    SET is_archived = TRUE, archived_date = CURRENT_DATE
    WHERE channelID = %s;
    '''
    for channel in inactive_channels:
        archive_cmd = cur.mogrify(archive_tmpl, (channel[0],))
        print_cmd(archive_cmd)
        cur.execute(archive_cmd)

    # Show updated channels
    show_table(inactive_channels, cols)
    print(f"Archived {len(inactive_channels)} channels.")


archive_inactive_channels(30)