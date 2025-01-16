from common import *

us = '''
* US9

   As a:  Content Moderator
 I want:  To flag inappropriate messages and assign them to a moderator based on the channel type
So That:  Each flagged message is handled by the appropriate moderator responsible for that type of channel.
'''

print(us)

def flag_and_assign_messages(keyword, moderator_id, moderation_area):
    tmpl = '''
    -- Flag inappropriate messages and retrieve them
    WITH flagged_messages AS (
        UPDATE Message
        SET isFlagged = TRUE
        WHERE content ILIKE '%%' || %s || '%%'
        RETURNING messageID, content
    ),
    updated_moderator AS (
        -- Increment flaggedMessageCount for the specified moderator
        UPDATE ContentModerator
        SET flaggedMessageCount = flaggedMessageCount + (
            SELECT COUNT(*) FROM flagged_messages
        )
        WHERE userID = %s AND Moderation_Area = %s
        RETURNING userID, Moderation_Area, flaggedMessageCount
    )
    -- Output the result
    SELECT fm.messageID, fm.content, %s AS assigned_moderator_id
    FROM flagged_messages fm;
    '''
    cmd = cur.mogrify(tmpl, (keyword, moderator_id, moderation_area, moderator_id))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    pp(rows)
    show_table(rows, 'messageID content assigned_moderator_id')

flag_and_assign_messages('spam', 1, 'Gaming')
