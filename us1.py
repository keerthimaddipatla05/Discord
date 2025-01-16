from common import *

us='''
* US1

   As a:  Member
 I want:  To view the most active channels in the server
So That:  I can join and participate in high-engagement areas
'''

def rank_channels():
    tmpl = '''
    SELECT channelID, COUNT(*) AS message_count
    FROM Message
    GROUP BY channelID
    ORDER BY message_count DESC;
    '''
    cmd = cur.mogrify(tmpl, ())
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    pp(rows)
    show_table(rows, 'channelID message_count')

rank_channels()

