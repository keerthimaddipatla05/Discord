from common import *

us = '''
* US10

   As a:  Content Moderator
 I want:  To identify servers with the highest rate of flagged content
So That:  I can focus my attention on high-risk areas
'''

print(us)

def flagged_content_summary():
    cols = 'serverID flagged_count'

    tmpl = '''
    SELECT c.serverID, COUNT(*) AS flagged_count
    FROM MessageStatus ms
    JOIN Message m ON ms.messageID = m.messageID
    JOIN Channel c ON m.channelID = c.channelID
    GROUP BY c.serverID
    ORDER BY flagged_count DESC;
    '''
    cmd = cur.mogrify(tmpl, ())
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    pp(rows)
    show_table(rows, cols)

# Demonstrate the function
flagged_content_summary()
