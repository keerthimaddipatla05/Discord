-- show_all.sql
-- Script to display the contents of all tables in the 'project' database.

\connect project

-- 1. Displaying contents of Users Table
\echo 'Contents of Users Table:'
SELECT * FROM Users;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 2. Displaying contents of ServerOwner Table
\echo 'Contents of ServerOwner Table:'
SELECT * FROM ServerOwner;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 3. Displaying contents of CommunityMember Table
\echo 'Contents of CommunityMember Table:'
SELECT * FROM CommunityMember;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 4. Displaying contents of ContentModerator Table
\echo 'Contents of ContentModerator Table:'
SELECT * FROM ContentModerator;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 5. Displaying contents of Server Table
\echo 'Contents of Server Table:'
SELECT * FROM Server;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 6. Displaying contents of UserRole Table
\echo 'Contents of UserRole Table:'
SELECT * FROM UserRole;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 7. Displaying contents of EngagementStatus Table
\echo 'Contents of EngagementStatus Table:'
SELECT * FROM EngagementStatus;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 8. Displaying contents of Channel Table
\echo 'Contents of Channel Table:'
SELECT * FROM Channel;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 9. Displaying contents of TextChannel Table
\echo 'Contents of TextChannel Table:'
SELECT * FROM TextChannel;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 10. Displaying contents of VoiceChannel Table
\echo 'Contents of VoiceChannel Table:'
SELECT * FROM VoiceChannel;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 11. Displaying contents of Message Table
\echo 'Contents of Message Table:'
SELECT * FROM Message;

-- Add a separator for readability
\echo '-----------------------------------------'

-- 12. Displaying contents of MessageStatus Table
\echo 'Contents of MessageStatus Table:'
SELECT * FROM MessageStatus;

-- Add a separator for readability
\echo '-----------------------------------------'

-- End of the script
\echo 'End of database dump.'
