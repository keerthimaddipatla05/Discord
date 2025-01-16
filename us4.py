from common import *

us = '''
* US4: Aggregate Flagged Keywords by Count

   As a:  Content Moderator
 I want:  To track the most common keywords flagged in messages across servers
So That:  I can monitor them more closely
'''

print(us)

def aggregate_flagged_keywords():
    cols = 'keyword keyword_count'

    tmpl = '''
    SELECT keyword, COUNT(*) AS keyword_count
    FROM MessageStatus
    GROUP BY keyword
    ORDER BY keyword_count DESC;
    '''
    cmd = cur.mogrify(tmpl, ())
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    pp(rows)
    show_table(rows, cols)

# Demonstrate the function
aggregate_flagged_keywords()
