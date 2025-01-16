from common import *

us = '''
* US3
   As a:  Member
 I want:  To see if there is enough space in a voice channel for new participants
So That:  I can decide whether to join the channel or not
'''

print(us)

def check_voice_channel_availability(channelID):
    # SQL query to check voice channel availability
    tmpl = '''
        SELECT
            vc.channelID,
            vc.maxParticipants,
            COUNT(es.userID) AS currPtcp,
            CASE
                WHEN COUNT(es.userID) < vc.maxParticipants THEN 'Yes'
                ELSE 'No'
            END AS isAvailable
        FROM VoiceChannel AS vc
        LEFT JOIN EngagementStatus AS es ON vc.channelID = es.channelID
        WHERE vc.channelID = %s
        GROUP BY vc.channelID, vc.maxParticipants;
    '''

    # Execute the query
    cmd = cur.mogrify(tmpl, (channelID,))
    print_cmd(cmd)  # Print the SQL query for debugging
    cur.execute(cmd)
    rows = cur.fetchall()

    # Check if the channel exists
    if not rows:
        print(f"No data found for Channel ID: {channelID}")
        return

    # Display the results
    print("Voice Channel Availability:")
    print(f"{'Channel ID':<15} {'Max Participants':<20} {'Current Participants':<20} {'Is Available':<15}")
    print("-" * 70)
    for row in rows:
        print(f"{row[0]:<15} {row[1]:<20} {row[2]:<20} {row[3]:<15}")

# Example Usage
channelID = int(input("Enter the Channel ID to check availability: ").strip())
check_voice_channel_availability(channelID)
