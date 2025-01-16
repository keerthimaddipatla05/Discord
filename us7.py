from common import *

us = '''
* US7
   As a:  Member
 I want:  Search for a word across all messages in all channels of a server
So That:  I can find relevant discussions
'''

print(us)

def search_messages_by_word(serverID, searchWord):
    # SQL query
    tmpl = '''SELECT Channel.channelName, Message.userID, Message.timestamp, Message.content
        FROM Server
        JOIN Channel ON Server.serverID = Channel.serverID
        JOIN Message ON Channel.channelID = Message.channelID
        WHERE Server.serverID = %s AND Message.content ILIKE %s
        ORDER BY Channel.channelName, Message.timestamp;
    '''
    
    cmd = cur.mogrify(tmpl, (serverID, f"%{searchWord}%"))
    print_cmd(cmd) 
    cur.execute(cmd)
    rows = cur.fetchall()

    # Check for results and output
    if not rows:
        print("No messages found.")
    else:
        print("Messages found:")
        for row in rows:
            print(f"Channel: {row[0]}, UserID: {row[1]}, Timestamp: {row[2]}, Content: {row[3]}")

serverID = int(input("Enter the server ID: ").strip())
searchWord = input("Enter the word to search for: ").strip()
search_messages_by_word(serverID, searchWord)

# example scenario
#ServerID = 1, searchWord = spam expecet result: no message found.