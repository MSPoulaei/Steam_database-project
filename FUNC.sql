--STORED PROCEDURE
CREATE PROCEDURE SEND_MESSAGE @USERID1 INTEGER,
                              @USERID2 INTEGER,
                              @MESSAGE NVARCHAR(MAX)
AS
DECLARE @CHATID INTEGER;
    SET @CHATID = (SELECT MAX(ID)
                   FROM Chat) + 1;
    IF EXISTS(SELECT ID
              FROM Chat
              WHERE (StarterID = @USERID1 AND ReceiverID = @USERID2)
                 OR (StarterID = @USERID2 AND ReceiverID = @USERID1))
        BEGIN
            SET @CHATID = (SELECT TOP 1 ID
                           FROM Chat
                           WHERE (StarterID = @USERID1 AND ReceiverID = @USERID2)
                              OR (StarterID = @USERID2 AND ReceiverID = @USERID1));
        END
    ELSE
        BEGIN
            INSERT INTO Chat(ID, StarterID, ReceiverID, DateCreated)
            VALUES (@CHATID, @USERID1, @USERID2, SYSDATETIME());
        END
DECLARE @MESSAGEID INTEGER;
    SET @MESSAGEID = (SELECT MAX(ID)
                      FROM Message) + 1;


INSERT INTO Message(ID, SenderID, ChatID, Content, DateCreated, isRead, isDeleted)
VALUES (@MESSAGEID, @USERID1, @CHATID, @MESSAGE, SYSDATETIME(), 0, 0);
GO



EXEC SEND_MESSAGE @USERID1 = 2, @USERID2 = 3, @MESSAGE = N'من برگشتم';
-- DELETE Message WHERE ID=3 OR ID=4;

SELECT *
FROM Message;
SELECT *
FROM Chat;

CREATE PROCEDURE READ_MESSAGE @USERID1 INTEGER,
                              @USERID2 INTEGER,
                              @MESSAGE NVARCHAR(MAX)
AS
DECLARE @CHATID INTEGER;
    SET @CHATID = (SELECT TOP 1 ID
                   FROM Chat C
                   WHERE C.StarterID = @USERID1
                     AND C.ReceiverID = @USERID2);

DECLARE @MESSAGEID INTEGER;
    SET @MESSAGEID = (SELECT TOP 1 ID
                      FROM Message M
                      WHERE M.ChatID = @CHATID
                        AND M.Content = @MESSAGE);

UPDATE Message
SET isRead=1
WHERE ID = @MESSAGEID;

GO


EXEC READ_MESSAGE @USERID1 = 2, @USERID2 = 3, @MESSAGE = N'من برگشتم';
SELECT *
FROM Message;
SELECT *
FROM Chat;

--FUNCTIONS

CREATE FUNCTION GET_FOLLOWEES(@USERID INTEGER)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT G.*
                FROM FollowGame FG
                         INNER JOIN Game G on G.GameID = FG.GameID
                WHERE FG.FollowerID = @USERID
            );

GO

SELECT *
FROM GET_FOLLOWEES(2);

CREATE FUNCTION GET_FOLLOWERS(@GAMEID INTEGER)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT U.*
                FROM FollowGame FG
                         INNER JOIN [User] U on U.UserID = FG.FollowerID
                WHERE FG.GameID = @GAMEID
            );

GO

SELECT *
FROM GET_FOLLOWERS(1);
SELECT *
FROM GET_FOLLOWERS(2);
SELECT *
FROM GET_FOLLOWERS(3);
--TRIGGER

CREATE TRIGGER BUYGAME_NO_SELL
    ON UserGame
    FOR INSERT
    AS
    UPDATE GAME
    SET NOofSells=NOofSells + 1
    WHERE GameID = (SELECT GameID FROM inserted);

GO
CREATE TRIGGER BUY_ORDER
    ON [Order]
    FOR INSERT
    AS
    IF ((SELECT I.isSuccessfull
         FROM inserted I) = 1)
        BEGIN
            DECLARE @ID INTEGER;
            IF EXISTS(SELECT ID FROM UserGame)
                BEGIN
                    SET @ID = (SELECT MAX(ID) FROM UserGame) + 1;
                END
            ELSE
                BEGIN
                    SET @ID = 1;
                END
            DECLARE @USERID INTEGER =(SELECT UserID
                                      FROM ShoppingCart SC,
                                           inserted I
                                      WHERE I.ShoppingCartID = SC.ID);
            DECLARE @GAMEID INTEGER;
--https://www.mssqltips.com/sqlservertip/6148/sql-server-loop-through-table-rows-without-cursor/
            DECLARE CUR_TEST CURSOR FAST_FORWARD FOR
                SELECT GameID
                FROM ShoppingCartGame SCG,
                     inserted I
                WHERE I.ShoppingCartID = SCG.ShoppingCartID;

            OPEN CUR_TEST
            FETCH NEXT FROM CUR_TEST INTO @GAMEID

            WHILE @@FETCH_STATUS = 0
                BEGIN
                    INSERT INTO UserGame(ID, HoursPlayed, UserID, GameID)
                    SELECT @ID
                         , 0
                         , @USERID
                         , @GAMEID
                    FROM inserted I

                    SET @ID = @ID + 1;

                    FETCH NEXT FROM CUR_TEST INTO @GAMEID
                END
            CLOSE CUR_TEST
            DEALLOCATE CUR_TEST

        END

GO

SELECT *
FROM GAME

--VIEWS

CREATE VIEW POPULAR_GAMES
AS
SELECT TOP 1000 G.GameID, G.Title, AVG(R.Points) AS AVG_POINT
FROM [Game] G
         LEFT OUTER JOIN Review R ON G.GameID = R.GameID
GROUP BY G.GameID, R.Points, G.Title
ORDER BY AVG(R.Points) DESC

GO

SELECT *
FROM POPULAR_GAMES;


-- DROP VIEW GAMES_PAGES;
CREATE VIEW GAMES_PAGES
AS
SELECT G.*,
       D.*,
       GE.NAME  AS GENRE,
       T.NAME   AS TAG,
       L.Name   AS LANG,
       EA.Title AS EVENT,
       A.Name   AS ACCESS,
       F.Name   AS FRANCHISE
FROM [Game] G
         LEFT OUTER JOIN GameDeveloper GD ON G.GameID = GD.GameID
         LEFT OUTER JOIN Developer D ON GD.DeveloperID = D.ID
         LEFT OUTER JOIN GameGenre GG ON G.GameID = GG.GameID
         LEFT OUTER JOIN Genre GE on GE.GenreID = GG.GenreID
         LEFT OUTER JOIN GameLanguage GL on G.GameID = GL.GameID
         LEFT OUTER JOIN LANGUAGE L on GL.LanguageID = L.ID
         LEFT OUTER JOIN GameTag GT on G.GameID = GT.GameID
         LEFT OUTER JOIN TAG T on GT.TagID = T.TAGID
         LEFT OUTER JOIN EventsAnnouncements EA on G.GameID = EA.GameID
         LEFT OUTER JOIN Access A on G.AccessID = A.AccessID
         LEFT OUTER JOIN Franchise F on G.FranchiseID = F.FranchiseID

GO

SELECT *
FROM GAMES_PAGES;
