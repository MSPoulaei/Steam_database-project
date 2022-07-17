USE MASTER;
--DROP DATABASE STEAM_DB;
CREATE DATABASE STEAM_DB;
USE STEAM_DB;

CREATE TABLE [Game]
(
    GameID       INTEGER PRIMARY KEY,
    Title        NVARCHAR(150) NOT NULL,
    Price        MONEY,
    AccessID     INTEGER,
    FranchiseID  INTEGER,
    ReleaseDate  DATE,
    About        NVARCHAR(MAX),
    OS_ID        INTEGER,
    NOofPlayerID INTEGER,
    PublisherID  INTEGER       NOT NULL,
    NOofSells INTEGER DEFAULT 0,
--     PRIMARY KEY (GameID, TITLE),

)
GO

CREATE TABLE [Access]
(
    AccessID INTEGER PRIMARY KEY,
    Name     NVARCHAR(150) NOT NULL,


)
GO
CREATE TABLE [Franchise]
(
    FranchiseID INTEGER PRIMARY KEY,
    Name        NVARCHAR(150) NOT NULL,


)
GO
CREATE TABLE [Genre]
(
    GenreID INTEGER PRIMARY KEY,
    NAME    NVARCHAR(150) NOT NULL,


)
GO
CREATE TABLE [GameGenre]
(
    ID      INTEGER PRIMARY KEY,
    GameID  INTEGER NOT NULL,
    GenreID INTEGER NOT NULL,
--     PRIMARY KEY (GAMEID, GENREID),


)
GO
CREATE TABLE [OS]
(
    OS_ID  INTEGER PRIMARY KEY,
    OSName NVARCHAR(150) NOT NULL,


)
GO
CREATE TABLE [NOofPlayer]
(
    NOofPlayerID INTEGER PRIMARY KEY,
    Name         NVARCHAR(150) NOT NULL,


)
GO
CREATE TABLE [Offer]
(
    OfferID            INTEGER PRIMARY KEY,
    DueTime            DATETIME NOT NULL,
    DiscountPercentage FLOAT    NOT NULL,
    GameID             INTEGER  NOT NULL,


)
GO
CREATE TABLE [Achievement]
(
    AchievementID INTEGER PRIMARY KEY,
    Title         NVARCHAR(150) NOT NULL,
    Count         INTEGER       NOT NULL,
    GameID        INTEGER       NOT NULL,


)
GO
CREATE TABLE [User]
(
    UserID       INTEGER       NOT NULL PRIMARY KEY ,
    UserName     NVARCHAR(150) NOT NULL,
    Email        NVARCHAR(150) NOT NULL UNIQUE,
    Password     NVARCHAR(150) NOT NULL,
    NickName     NVARCHAR(150),
    BirthDate    DATE,
    Sex          BIT,
    Level        INTEGER       NOT NULL DEFAULT '1',
    ProfilePic   NVARCHAR(150),
    XP           BIGINT        NOT NULL,
    Balance      MONEY         NOT NULL ,
    MobileNumber NVARCHAR(20),
    LanguageID   INTEGER       NOT NULL,
--     PRIMARY KEY (USERID, USERNAME, EMAIL),


)
GO
CREATE TABLE [WishList]
(
    WishListID INTEGER  PRIMARY KEY,
    UserID INTEGER NOT NULL,
    GameID INTEGER NOT NULL,
--     PRIMARY KEY (UserID, GameID),


)
GO
CREATE TABLE [GainedAchievement]
(
    GAID INTEGER PRIMARY KEY ,
    UserGameID    INTEGER NOT NULL,
    AchievementID INTEGER NOT NULL,
--     PRIMARY KEY (UserGameID, AchievementID),


)
GO
CREATE TABLE [Update]
(
    UpdateID INTEGER PRIMARY KEY,
    GameId   INTEGER       NOT NULL,
    Name     NVARCHAR(150),
    Version  NVARCHAR(150) NOT NULL,
    Log      NVARCHAR(150),
    DLLink   NVARCHAR(150) NOT NULL,


)
GO
CREATE TABLE [SystemRequirements]
(
    SystemReqID INTEGER PRIMARY KEY,
    GameID      INTEGER       NOT NULL,
    CPU         NVARCHAR(150) NOT NULL,
    GPU         NVARCHAR(150),
    RAM         NVARCHAR(150) NOT NULL,
    HDD         NVARCHAR(150),


)
GO

ALTER TABLE [SystemRequirements]
ADD Extra NVARCHAR(MAX);

GO
CREATE TABLE [Developer]
(
    ID     INTEGER PRIMARY KEY,
    Name   NVARCHAR(150) NOT NULL UNIQUE,
    -- #TODO NAME DECISION
    UserID INTEGER FOREIGN KEY REFERENCES [User] (UserID),


)
GO

CREATE TABLE [GameDeveloper]
(
    ID          INTEGER PRIMARY KEY,
    GameID      INTEGER NOT NULL,
    DeveloperID INTEGER NOT NULL,
--     PRIMARY KEY (GameID, DeveloperID),


)
GO
CREATE TABLE [EventsAnnouncements]
(
    PostID   INTEGER       PRIMARY KEY ,
    Title    NVARCHAR(150) NOT NULL,
    Text     NVARCHAR(MAX) NOT NULL,
    PostDate DATETIME,
    GameID   INTEGER       NOT NULL,


)
GO
CREATE TABLE [Picture]
(
    PicID   INTEGER  PRIMARY KEY,
    PicLink INTEGER NOT NULL,
    PostID  INTEGER NOT NULL,


)
GO
CREATE TABLE [GameLanguage]
(
    ID         INTEGER PRIMARY KEY,
    Interface  BIT     NOT NULL,
    Audio      BIT     NOT NULL,
    Subtitle   BIT     NOT NULL,
    GameID     INTEGER NOT NULL,
    LanguageID INTEGER NOT NULL,


)
GO
CREATE TABLE [Publisher]
(
    ID          INTEGER        PRIMARY KEY,
    Name        NVARCHAR(150) NOT NULL,
    UserID      INTEGER FOREIGN KEY REFERENCES [User] (UserID) ON UPDATE CASCADE,
    Description NVARCHAR(MAX),


)
GO
CREATE TABLE FollowPublisher
(
    ID          INTEGER PRIMARY KEY,
    PublisherID INTEGER NOT NULL,
    FollowerID  INTEGER NOT NULL,
--     PRIMARY KEY (PublisherID, FollowerID),


)
GO
CREATE TABLE [SocialMediaLinks]
(
    ID          INTEGER       PRIMARY KEY,
    PublisherID INTEGER       NOT NULL,
    SiteName    NVARCHAR(150) NOT NULL,
    Link        NVARCHAR(150) NOT NULL,


)
GO
CREATE TABLE [Review]
(
    ID           INTEGER        PRIMARY KEY,
    ReviewerName NVARCHAR(150) NOT NULL,
    Points       FLOAT         NOT NULL,
    Text         NVARCHAR(MAX) NOT NULL,
    CreationDate DATETIME      NOT NULL,
    GameID       INTEGER       NOT NULL,


)
GO
CREATE TABLE [ShoppingCart]
(
    ID     INTEGER PRIMARY KEY ,
    UserID INTEGER NOT NULL,
--     PRIMARY KEY (ID, UserID),


)
GO
CREATE TABLE [ShoppingCartGame]
(
    ID             INTEGER PRIMARY KEY,
    ShoppingCartID INTEGER NOT NULL,
    GameID         INTEGER NOT NULL,
--     PRIMARY KEY (ShoppingCartID, GameID),


)
GO
CREATE TABLE [Order]
(
    ID             INTEGER  PRIMARY KEY,
    ShoppingCartID INTEGER NOT NULL,
    isSuccessfull  BIT     NOT NULL,
    TotalCost      decimal NOT NULL,
    PaidCost       decimal NOT NULL,
    DateCreated    DATETIME,


)
GO
CREATE TABLE [UserGame]
(
    ID          INTEGER  PRIMARY KEY,
    HoursPlayed FLOAT   NOT NULL DEFAULT '0',
    UserID      INTEGER NOT NULL,
    GameID      INTEGER NOT NULL,


)
GO
CREATE TABLE [Comment]
(
    CommentID    INTEGER    PRIMARY KEY,
    UserID       INTEGER       NOT NULL,
    GameID       INTEGER       NOT NULL,
    Score        FLOAT         NOT NULL,
    Title        NVARCHAR(150) NOT NULL,
    Text         NVARCHAR(MAX) NOT NULL,
    CreationDate DATETIME,


)
GO
CREATE TABLE [Language]
(
    ID   INTEGER        PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,


)
GO
CREATE TABLE [Friendship]
(
    ID            INTEGER PRIMARY KEY,
    RequesterID   INTEGER  NOT NULL,
    RecieverID    INTEGER  NOT NULL,
    isAccepted    BIT      NOT NULL,
    RequestedDate DATETIME NOT NULL,
    AcceptedDate  DATETIME,


)
GO
CREATE TABLE [Chat]
(
    ID          INTEGER  PRIMARY KEY,
    StarterID   INTEGER  NOT NULL,
    ReceiverID  INTEGER  NOT NULL,
    DateCreated DATETIME NOT NULL,
    isDeleted   BIT      NOT NULL DEFAULT '0',


)
GO
CREATE TABLE [Message]
(
    ID          INTEGER   PRIMARY KEY,
    SenderID    INTEGER       NOT NULL,
    ChatID      INTEGER       NOT NULL,
    Content     NVARCHAR(MAX) NOT NULL,
    DateCreated DATETIME      NOT NULL,
    isRead      BIT           NOT NULL,
    isDeleted   BIT           NOT NULL,


)
GO
CREATE TABLE TAG
(
    TAGID INTEGER PRIMARY KEY,
    NAME  NVARCHAR(150) NOT NULL,

)
GO
CREATE TABLE GameTag
(
    ID     INTEGER PRIMARY KEY,
    GameID INTEGER,
    TagID  INTEGER,
--     PRIMARY KEY (GameID, TagID),
    FOREIGN KEY (GameID) REFERENCES Game (GameID) ON UPDATE CASCADE,
    FOREIGN KEY (TagID) REFERENCES TAG (TAGID) ON UPDATE CASCADE,
)
GO
CREATE TABLE FollowGame
(
    ID         INTEGER PRIMARY KEY,
    GameID     INTEGER,
    FollowerID INTEGER,
--     PRIMARY KEY (GameID, FollowerID),
    FOREIGN KEY (GameID) REFERENCES Game (GameID) ON UPDATE CASCADE,
    FOREIGN KEY (FollowerID) REFERENCES [User] (UserID) ON UPDATE CASCADE,
)


GO

-- ALTER TABLE Developer
--     ADD FOREIGN KEY (UserID) REFERENCES [User] (UserID)

GO
ALTER TABLE [Game]
    WITH CHECK ADD CONSTRAINT [Game_fk0] FOREIGN KEY (AccessID) REFERENCES [Access] (AccessID)
        ON UPDATE CASCADE
GO
ALTER TABLE [Game]
    CHECK CONSTRAINT [Game_fk0]
GO
ALTER TABLE [Game]
    WITH CHECK ADD CONSTRAINT [Game_fk1] FOREIGN KEY (FranchiseID) REFERENCES [Franchise] ([FranchiseID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Game]
    CHECK CONSTRAINT [Game_fk1]
GO
ALTER TABLE [Game]
    WITH CHECK ADD CONSTRAINT [Game_fk2] FOREIGN KEY (OS_ID) REFERENCES [OS] ([OS_ID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Game]
    CHECK CONSTRAINT [Game_fk2]
GO
ALTER TABLE [Game]
    WITH CHECK ADD CONSTRAINT [Game_fk3] FOREIGN KEY (NOofPlayerID) REFERENCES [NOofPlayer] ([NOofPlayerID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Game]
    CHECK CONSTRAINT [Game_fk3]
GO
ALTER TABLE [Game]
    WITH CHECK ADD CONSTRAINT [Game_fk4] FOREIGN KEY ([PublisherID]) REFERENCES [Publisher] ([ID])
GO
ALTER TABLE [Game]
    CHECK CONSTRAINT [Game_fk4]
GO



ALTER TABLE [GameGenre]
    WITH CHECK ADD CONSTRAINT [GameGenre_fk0] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [GameGenre]
    CHECK CONSTRAINT [GameGenre_fk0]
GO
ALTER TABLE [GameGenre]
    WITH CHECK ADD CONSTRAINT [GameGenre_fk1] FOREIGN KEY ([GenreID]) REFERENCES [Genre] ([GenreID])
        ON UPDATE CASCADE
GO
ALTER TABLE [GameGenre]
    CHECK CONSTRAINT [GameGenre_fk1]
GO



ALTER TABLE [Offer]
    WITH CHECK ADD CONSTRAINT [Offer_fk0] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [Offer]
    CHECK CONSTRAINT [Offer_fk0]
GO

ALTER TABLE [Achievement]
    WITH CHECK ADD CONSTRAINT [Achievement_fk0] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [Achievement]
    CHECK CONSTRAINT [Achievement_fk0]
GO

ALTER TABLE [User]
    WITH CHECK ADD CONSTRAINT [User_fk0] FOREIGN KEY ([LanguageID]) REFERENCES [Language] ([ID])
        ON UPDATE CASCADE
GO
ALTER TABLE [User]
    CHECK CONSTRAINT [User_fk0]
GO

ALTER TABLE [WishList]
    WITH CHECK ADD CONSTRAINT [WishList_fk0] FOREIGN KEY ([UserID]) REFERENCES [User] ([UserID])
        ON UPDATE CASCADE
GO
ALTER TABLE [WishList]
    CHECK CONSTRAINT [WishList_fk0]
GO
ALTER TABLE [WishList]
    WITH CHECK ADD CONSTRAINT [WishList_fk1] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [WishList]
    CHECK CONSTRAINT [WishList_fk1]
GO

ALTER TABLE [GainedAchievement]
    WITH CHECK ADD CONSTRAINT [GainedAchievement_fk0] FOREIGN KEY ([UserGameID]) REFERENCES [UserGame] ([ID])
        ON UPDATE CASCADE
GO
ALTER TABLE [GainedAchievement]
    CHECK CONSTRAINT [GainedAchievement_fk0]
GO
ALTER TABLE [GainedAchievement]
    WITH CHECK ADD CONSTRAINT [GainedAchievement_fk1] FOREIGN KEY ([AchievementID]) REFERENCES [Achievement] ([AchievementID])
        ON UPDATE CASCADE
GO
ALTER TABLE [GainedAchievement]
    CHECK CONSTRAINT [GainedAchievement_fk1]
GO

ALTER TABLE [Update]
    WITH CHECK ADD CONSTRAINT [Update_fk0] FOREIGN KEY ([GameId]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [Update]
    CHECK CONSTRAINT [Update_fk0]
GO

ALTER TABLE [SystemRequirements]
    WITH CHECK ADD CONSTRAINT [SystemRequirements_fk0] FOREIGN KEY (GameID) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [SystemRequirements]
    CHECK CONSTRAINT [SystemRequirements_fk0]
GO


ALTER TABLE [GameDeveloper]
    WITH CHECK ADD CONSTRAINT [GameDeveloper_fk0] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [GameDeveloper]
    CHECK CONSTRAINT [GameDeveloper_fk0]
GO
ALTER TABLE [GameDeveloper]
    WITH CHECK ADD CONSTRAINT [GameDeveloper_fk1] FOREIGN KEY ([DeveloperID]) REFERENCES [Developer] ([ID])
        ON UPDATE CASCADE
GO
ALTER TABLE [GameDeveloper]
    CHECK CONSTRAINT [GameDeveloper_fk1]
GO

ALTER TABLE [EventsAnnouncements]
    WITH CHECK ADD CONSTRAINT [EventsAnnouncements_fk0] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [EventsAnnouncements]
    CHECK CONSTRAINT [EventsAnnouncements_fk0]
GO

ALTER TABLE [Picture]
    WITH CHECK ADD CONSTRAINT [Picture_fk0] FOREIGN KEY ([PostID]) REFERENCES [EventsAnnouncements] ([PostID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Picture]
    CHECK CONSTRAINT [Picture_fk0]
GO

ALTER TABLE [GameLanguage]
    WITH CHECK ADD CONSTRAINT [GameLanguage_fk0] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [GameLanguage]
    CHECK CONSTRAINT [GameLanguage_fk0]
GO
ALTER TABLE [GameLanguage]
    WITH CHECK ADD CONSTRAINT [GameLanguage_fk1] FOREIGN KEY ([LanguageID]) REFERENCES [Language] ([ID])
        ON UPDATE CASCADE
GO
ALTER TABLE [GameLanguage]
    CHECK CONSTRAINT [GameLanguage_fk1]
GO


ALTER TABLE FollowPublisher
    WITH CHECK ADD CONSTRAINT [Follow_fk0] FOREIGN KEY ([PublisherID]) REFERENCES [Publisher] ([ID])
        ON UPDATE CASCADE
GO
ALTER TABLE FollowPublisher
    CHECK CONSTRAINT [Follow_fk0]
GO
ALTER TABLE FollowPublisher
    WITH CHECK ADD CONSTRAINT [Follow_fk1] FOREIGN KEY ([FollowerID]) REFERENCES [User] ([UserID])
GO
ALTER TABLE FollowPublisher
    CHECK CONSTRAINT [Follow_fk1]
GO

ALTER TABLE [SocialMediaLinks]
    WITH CHECK ADD CONSTRAINT [SocialMediaLinks_fk0] FOREIGN KEY ([PublisherID]) REFERENCES [Publisher] ([ID])
        ON UPDATE CASCADE
GO
ALTER TABLE [SocialMediaLinks]
    CHECK CONSTRAINT [SocialMediaLinks_fk0]
GO

ALTER TABLE [Review]
    WITH CHECK ADD CONSTRAINT [Review_fk0] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [Review]
    CHECK CONSTRAINT [Review_fk0]
GO

ALTER TABLE [ShoppingCart]
    WITH CHECK ADD CONSTRAINT [ShoppingCart_fk0] FOREIGN KEY ([UserID]) REFERENCES [User] ([UserID])
        ON UPDATE CASCADE
GO
ALTER TABLE [ShoppingCart]
    CHECK CONSTRAINT [ShoppingCart_fk0]
GO

ALTER TABLE [ShoppingCartGame]
    WITH CHECK ADD CONSTRAINT [ShoppingCartGame_fk0] FOREIGN KEY ([ShoppingCartID]) REFERENCES [ShoppingCart] ([ID])
        ON UPDATE CASCADE
GO
ALTER TABLE [ShoppingCartGame]
    CHECK CONSTRAINT [ShoppingCartGame_fk0]
GO
ALTER TABLE [ShoppingCartGame]
    WITH CHECK ADD CONSTRAINT [ShoppingCartGame_fk1] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [ShoppingCartGame]
    CHECK CONSTRAINT [ShoppingCartGame_fk1]
GO

ALTER TABLE [Order]
    WITH CHECK ADD CONSTRAINT [Order_fk0] FOREIGN KEY ([ShoppingCartID]) REFERENCES [ShoppingCart] ([ID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Order]
    CHECK CONSTRAINT [Order_fk0]
GO

ALTER TABLE [UserGame]
    WITH CHECK ADD CONSTRAINT [UserGame_fk0] FOREIGN KEY ([UserID]) REFERENCES [User] ([UserID])
        ON UPDATE CASCADE
GO
ALTER TABLE [UserGame]
    CHECK CONSTRAINT [UserGame_fk0]
GO
ALTER TABLE [UserGame]
    WITH CHECK ADD CONSTRAINT [UserGame_fk1] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
GO
ALTER TABLE [UserGame]
    CHECK CONSTRAINT [UserGame_fk1]
GO

ALTER TABLE [Comment]
    WITH CHECK ADD CONSTRAINT [Comment_fk0] FOREIGN KEY ([UserID]) REFERENCES [User] ([UserID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Comment]
    CHECK CONSTRAINT [Comment_fk0]
GO
ALTER TABLE [Comment]
    WITH CHECK ADD CONSTRAINT [Comment_fk1] FOREIGN KEY ([GameID]) REFERENCES [Game] (GameID)
        ON UPDATE CASCADE
GO
ALTER TABLE [Comment]
    CHECK CONSTRAINT [Comment_fk1]
GO


ALTER TABLE [Friendship]
    WITH CHECK ADD CONSTRAINT [Friendship_fk0] FOREIGN KEY ([RequesterID]) REFERENCES [User] ([UserID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Friendship]
    CHECK CONSTRAINT [Friendship_fk0]
GO
ALTER TABLE [Friendship]
    WITH CHECK ADD CONSTRAINT [Friendship_fk1] FOREIGN KEY ([RecieverID]) REFERENCES [User] ([UserID])
GO
ALTER TABLE [Friendship]
    CHECK CONSTRAINT [Friendship_fk1]
GO

ALTER TABLE [Chat]
    WITH CHECK ADD CONSTRAINT [Chat_fk0] FOREIGN KEY (StarterID) REFERENCES [User] ([UserID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Chat]
    CHECK CONSTRAINT [Chat_fk0]
GO
ALTER TABLE [Chat]
    WITH CHECK ADD CONSTRAINT [Chat_fk1] FOREIGN KEY (ReceiverID) REFERENCES [User] ([UserID])
GO
ALTER TABLE [Chat]
    CHECK CONSTRAINT [Chat_fk1]
GO

ALTER TABLE [Message]
    WITH CHECK ADD CONSTRAINT [Message_fk0] FOREIGN KEY ([SenderID]) REFERENCES [User] ([UserID])
        ON UPDATE CASCADE
GO
ALTER TABLE [Message]
    CHECK CONSTRAINT [Message_fk0]
GO
ALTER TABLE [Message]
    WITH CHECK ADD CONSTRAINT [Message_fk1] FOREIGN KEY ([ChatID]) REFERENCES [Chat] ([ID])
GO
ALTER TABLE [Message]
    CHECK CONSTRAINT [Message_fk1]
GO

--MODIFY
ALTER TABLE [User]
    ADD CONSTRAINT C_XP DEFAULT 1 FOR XP
GO
ALTER TABLE [User]
    DROP CONSTRAINT C_XP
GO
ALTER TABLE [User]
    ADD CONSTRAINT C_XP DEFAULT 0 FOR XP
GO


ALTER TABLE [User]
    ADD CONSTRAINT C_BALANCE DEFAULT 1 FOR Balance
GO
ALTER TABLE [User]
    DROP CONSTRAINT C_BALANCE
GO
ALTER TABLE [User]
    ADD CONSTRAINT C_BALANCE DEFAULT 0 FOR Balance
GO

ALTER TABLE [User]
    ADD CHECK (XP>=0)
GO


