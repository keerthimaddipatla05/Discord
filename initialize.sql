-- drop the project database if it exists
DROP DATABASE IF EXISTS project;

-- create it afresh
CREATE DATABASE project;
\c project

-- Create ENUM types
CREATE TYPE User_Type AS ENUM('Member', 'Server Owner', 'Content Moderator');

-- load the schema
\i create.SQL

-- load the data
\copy Users(userID, username, email, joinDate, isActive) FROM 'data/users.csv' CSV HEADER;
\copy Server(serverID, serverName, creationDate, description, userID) FROM 'data/server.csv' CSV HEADER;
\copy ServerOwner(userID, serverID, Ownership_Date) FROM 'data/server_owner.csv' CSV HEADER;
\copy CommunityMember(userID, Membership_Date) FROM 'data/community_member.csv' CSV HEADER;
\copy ContentModerator(userID, Moderation_Area, flaggedMessageCount) FROM 'data/content_moderator.csv' CSV HEADER;
\copy UserRole(roleID, roleName, color, permissions, serverID) FROM 'data/user_role.csv' CSV HEADER;
\copy Channel(channelID, channelName, creationDate, requiredRole, serverID, is_archived, archived_date) FROM 'data/channel.csv' CSV HEADER;
\copy EngagementStatus(engagementID, message_Count, voice_channel_duration, last_active_date, userID, channelID) FROM 'data/engagement_status.csv' CSV HEADER;
\copy TextChannel(channelID, maxMessageLength) FROM 'data/text_channel.csv' CSV HEADER;
\copy VoiceChannel(channelID, maxParticipants) FROM 'data/voice_channel.csv' CSV HEADER;
\copy Message(messageID, content, timestamp, isFlagged, userID, channelID) FROM 'data/message.csv' CSV HEADER;
\copy MessageStatus(statusID, keyword, dateflagged, reason, Moderator_ID, Moderation_Area, messageID) FROM 'data/message_status.csv' CSV HEADER;
