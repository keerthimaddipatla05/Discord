from common import *

us = '''
* US6

   As a:  Server Owner
 I want:  To analyze message volume per channel over time
So That:  I can better tailor the server's organization
'''

print(us)

def message_counts_by_period(start_date, end_date):
    cols = 'channelID message_count'

    tmpl = '''
    SELECT channelID, COUNT(*) AS message_count
    FROM Message
    WHERE timestamp BETWEEN %s AND %s
    GROUP BY channelID
    ORDER BY message_count DESC;
    '''
    cmd = cur.mogrify(tmpl, (start_date, end_date))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    pp(rows)
    show_table(rows, cols)

# Demonstrate the function
# Example date range: '2024-01-01' to '2024-01-31'
message_counts_by_period('2024-01-01', '2024-01-31')
