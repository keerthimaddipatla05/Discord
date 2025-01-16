-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-12-06 10:00:00

-- tables
-- Table: Users
CREATE TABLE Users (
    userID int NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    joinDate timestamp NOT NULL,
    isActive boolean NOT NULL,
    CONSTRAINT Users_pk PRIMARY KEY (userID)
);

-- Table: ServerOwner
CREATE TABLE ServerOwner (
    userID int NOT NULL,
    serverID int NOT NULL,
    Ownership_Date timestamp NOT NULL,
    CONSTRAINT ServerOwner_pk PRIMARY KEY (userID, serverID)
);

-- Table: CommunityMember
CREATE TABLE CommunityMember (
    userID int NOT NULL,
    Membership_Date timestamp NOT NULL,
    CONSTRAINT CommunityMember_pk PRIMARY KEY (userID, Membership_Date)
);

-- Table: ContentModerator
CREATE TABLE ContentModerator (
    userID int NOT NULL,
    Moderation_Area text NOT NULL,
    flaggedMessageCount int DEFAULT 0,
    CONSTRAINT ContentModerator_pk PRIMARY KEY (userID, Moderation_Area)
);

-- Table: Server
CREATE TABLE Server (
    serverID int NOT NULL,
    serverName text NOT NULL,
    creationDate timestamp NOT NULL,
    description text NOT NULL,
    userID int NOT NULL,
    CONSTRAINT Server_pk PRIMARY KEY (serverID)
);

-- Table: UserRole
CREATE TABLE UserRole (
    roleID int NOT NULL,
    roleName text NOT NULL,
    color text NOT NULL,
    permissions text NOT NULL,
    serverID int NOT NULL,
    CONSTRAINT UserRole_pk PRIMARY KEY (roleID)
);

-- Table: EngagementStatus
CREATE TABLE EngagementStatus (
    engagementID int NOT NULL,
    message_Count int NOT NULL,
    voice_channel_duration interval NOT NULL,
    last_active_date timestamp NOT NULL,
    userID int NOT NULL,
    channelID int NOT NULL,
    CONSTRAINT EngagementStatus_pk PRIMARY KEY (engagementID)
);

-- Table: Channel
CREATE TABLE Channel (
    channelID int NOT NULL,
    channelName text NOT NULL,
    creationDate timestamp NOT NULL,
    requiredRole int NOT NULL,
    serverID int NOT NULL,
    is_archived BOOLEAN DEFAULT FALSE,
    archived_date TIMESTAMP, 
    CONSTRAINT Channel_pk PRIMARY KEY (channelID)
);

-- Table: TextChannel
CREATE TABLE TextChannel (
    channelID int NOT NULL,
    maxMessageLength int NOT NULL,
    CONSTRAINT TextChannel_pk PRIMARY KEY (channelID)
);

-- Table: VoiceChannel
CREATE TABLE VoiceChannel (
    channelID int NOT NULL,
    maxParticipants int NOT NULL,
    CONSTRAINT VoiceChannel_pk PRIMARY KEY (channelID)
);

-- Table: Message
CREATE TABLE Message (
    messageID int NOT NULL,
    content text NOT NULL,
    timestamp timestamp NOT NULL,
    isFlagged boolean NOT NULL,
    userID int NOT NULL,
    channelID int NOT NULL,
    CONSTRAINT Message_pk PRIMARY KEY (messageID)
);

-- Table: MessageStatus
CREATE TABLE MessageStatus (
    statusID int NOT NULL,
    keyword text NOT NULL,
    dateflagged timestamp NOT NULL,
    reason text NOT NULL,
    Moderator_ID int NOT NULL,
    Moderation_Area text NOT NULL,
    messageID int NOT NULL,
    CONSTRAINT MessageStatus_pk PRIMARY KEY (statusID)
);

-- foreign keys
-- Reference: ServerOwner_Users (table: ServerOwner)
ALTER TABLE ServerOwner ADD CONSTRAINT ServerOwner_Users
    FOREIGN KEY (userID)
    REFERENCES Users (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: CommunityMember_Users (table: CommunityMember)
ALTER TABLE CommunityMember ADD CONSTRAINT CommunityMember_Users
    FOREIGN KEY (userID)
    REFERENCES Users (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: ContentModerator_Users (table: ContentModerator)
ALTER TABLE ContentModerator ADD CONSTRAINT ContentModerator_Users
    FOREIGN KEY (userID)
    REFERENCES Users (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: Server_Users (table: Server)
ALTER TABLE Server ADD CONSTRAINT Server_Users
    FOREIGN KEY (userID)
    REFERENCES Users (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: UserRole_Server (table: UserRole)
ALTER TABLE UserRole ADD CONSTRAINT UserRole_Server
    FOREIGN KEY (serverID)
    REFERENCES Server (serverID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: EngagementStatus_Users (table: EngagementStatus)
ALTER TABLE EngagementStatus ADD CONSTRAINT EngagementStatus_Users
    FOREIGN KEY (userID)
    REFERENCES Users (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: EngagementStatus_Channel (table: EngagementStatus)
ALTER TABLE EngagementStatus ADD CONSTRAINT EngagementStatus_Channel
    FOREIGN KEY (channelID)
    REFERENCES Channel (channelID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: Channel_Server (table: Channel)
ALTER TABLE Channel ADD CONSTRAINT Channel_Server
    FOREIGN KEY (serverID)
    REFERENCES Server (serverID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: Channel_UserRole (table: Channel)
ALTER TABLE Channel ADD CONSTRAINT Channel_UserRole
    FOREIGN KEY (requiredRole)
    REFERENCES UserRole (roleID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: TextChannel_Channel (table: TextChannel)
ALTER TABLE TextChannel ADD CONSTRAINT TextChannel_Channel_fk
    FOREIGN KEY (channelID)
    REFERENCES Channel (channelID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: VoiceChannel_Channel (table: VoiceChannel)
ALTER TABLE VoiceChannel ADD CONSTRAINT VoiceChannel_Channel_fk
    FOREIGN KEY (channelID)
    REFERENCES Channel (channelID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: Message_Users (table: Message)
ALTER TABLE Message ADD CONSTRAINT Message_Users
    FOREIGN KEY (userID)
    REFERENCES Users (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: Message_Channel (table: Message)
ALTER TABLE Message ADD CONSTRAINT Message_Channel
    FOREIGN KEY (channelID)
    REFERENCES Channel (channelID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: MessageStatus_Message (table: MessageStatus)
ALTER TABLE MessageStatus ADD CONSTRAINT MessageStatus_Message
    FOREIGN KEY (messageID)
    REFERENCES Message (messageID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Reference: MessageStatus_ContentModerator (table: MessageStatus)
ALTER TABLE MessageStatus ADD CONSTRAINT MessageStatus_ContentModerator
    FOREIGN KEY (Moderator_ID, Moderation_Area)
    REFERENCES ContentModerator (userID, Moderation_Area)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- End of file.
