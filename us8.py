from common import *

us = '''
* US8: Engagement Summary Across Servers

   As a:  Member
 I want:  To see my engagement summary across servers
So That:  I can track and manage my activity across communities
'''

print(us)

def engagement_summary(user_id):
    cols = 'serverID total_messages total_voice_time'

    tmpl = '''
    SELECT serverID, 
           SUM(message_Count) OVER (PARTITION BY serverID) AS total_messages,
           SUM(voice_channel_duration) OVER (PARTITION BY serverID) AS total_voice_time
    FROM EngagementStatus e
    JOIN Channel c ON e.channelID = c.channelID
    WHERE e.userID = %s;
    '''
    cmd = cur.mogrify(tmpl, (user_id,))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    pp(rows)
    show_table(rows, cols)

# Demonstrate the function
engagement_summary(1)
