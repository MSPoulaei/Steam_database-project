
--INSERT

INSERT INTO Access(AccessID, Name) VALUES
                    (1,'BETA'),
                    (2,'RELEASED'),
                    (3,'PRESELL')
GO

INSERT INTO Genre(GENREID, NAME) VALUES
                    (1,'ACTION'),
                    (2,'STRATEGY'),
                    (3,'ADVANTURE'),
                    (4,'OPEN WORLD')
GO

INSERT INTO Franchise(FranchiseID, Name) VALUES
                        (1,'GOD OF WAR'),
                        (2,'GTA')

GO

INSERT INTO OS(OS_ID, OSName) VALUES
                                  (1,'WINDOWS'),
                                  (2,'LINUX'),
                                  (3,'MAC OS')
GO

DELETE OS
WHERE OS_ID=3

GO


INSERT INTO NOofPlayer(NOofPlayerID, Name) VALUES
                        (1,'Single Player'),
                        (2,'Multi Player')

GO




INSERT INTO Language(ID, Name) VALUES
                                   (1,'ENGLISH'),
                                   (2,'PERSIAN'),
                                   (3,'ARABIC'),
                                   (4,'SPANISH'),
                                   (5,'FRENCH'),
                                   (6,'GERMAN'),
                                   (7,'PORTUGUESE')
GO

DELETE Language
WHERE ID=6

GO
INSERT INTO [User](UserID, UserName, Email, Password, NickName, BirthDate, Sex, Level, ProfilePic, XP, Balance, MobileNumber, LanguageID) VALUES
                    (1,'rockstarN','yah@gmail.com','123456',null,null,1,10,null,1500,1657122.4,'0911-111-2100',1),
                    (2,'sadegh369','sadegh@gmail.com','654123','Sadegh','2002-01-01',1,4,'sadegh-pic.png',100,0,'0937-231-7750',2),
                    (3,'reza123','REZA@gmail.com','rezaPaasswwworddd','Reza','1990-12-21',1,1,'reza-pic.png',3000,223.7,'0912-986-2063',2),
                    (4,'DANIAL_ORTEGA','DANIAL@gmail.com','123456','DANIAL','1990-12-21',1,1,'danial-pic.png',5000,12,'0912-986-2063',4),
                    (5,'Santa Monica Studio','MONICA@gmail.com','123456','SANTA','1980-09-01',1,1,'MONICA-pic.png',15000,9000,'0912-456-3547',1)
GO
INSERT INTO Publisher(ID, Name, UserID, Description) VALUES
                        (1,'ROCKSTAR',1,NULL),
                        (2,'PlayStation PC LLC',NULL,NULL)



GO
INSERT INTO Developer(ID, Name, UserID) VALUES
                                            (1,'ROCKSTAR NORTH',1),
                                            (2,'Santa Monica Studio',5)



INSERT INTO Game(GameID, Title, Price, AccessID, FranchiseID, ReleaseDate, About, OS_ID, NOofPlayerID, PublisherID) VALUES
                (1,'GTA V',59.99,2,2,'2013-01-01','When a young street hustler, a retired bank robber and a terrifying psychopath find themselves entangled with some of the most frightening and deranged elements of the criminal underworld, the U.S. government and the entertainment industry, they must pull off a series of dangerous heists to survive in a ruthless city in which they can trust nobody, least of all each other.',1,1,1),
                (2,'GOD OF WAR 4',49.99,1,1,'2018-01-01',NULL,1,1,2),
                (3,'GOD OF WAR 3',29.99,1,1,'2015-01-01',NULL,1,1,2)

GO

INSERT INTO GameGenre(ID, GameID, GenreID) VALUES
                        (1,1,4),
                        (2,2,1),
                        (3,2,3)


GO

INSERT INTO GameDeveloper(ID, GameID, DeveloperID) VALUES
                            (1,1,1),
                            (2,2,2),
                            (3,3,2)


GO



UPDATE GAME SET About=N'Enter the Norse realm His vengeance against the Gods of Olympus years behind him, Kratos now lives as a man in the realm of Norse Gods and monsters. It is in this harsh, unforgiving world that he must fight to survive… and teach his son to do the same.'
            WHERE GameID=2;

GO

INSERT INTO Chat(ID, StarterID, ReceiverID, DateCreated) VALUES
                (1,2,3,'2021-07-01')

INSERT INTO Message(ID, SenderID, ChatID, Content, DateCreated, isRead, isDeleted) VALUES
                    (1,2,1,N'سلام','2021-07-01 15:30:00',0,0),
                    (2,3,1,N'سلام','2021-07-01 15:30:50',0,0)

GO
UPDATE Message SET Content=N'سلام خوبی؟'
            WHERE ID=1;
GO

INSERT INTO FollowGame(ID, GameID, FollowerID) VALUES
                        (1,1,2),
                        (2,2,2)

GO

INSERT INTO Review(ID, ReviewerName, Points, Text, CreationDate, GameID) VALUES
                    (1,'ALI',4.1,'AWLI','2019-01-02 13:00:00',2),
                    (2,'AHMAD',4.4,'AWLI','2014-01-02 9:00:00',1)

GO

INSERT INTO ShoppingCart(ID, UserID) VALUES
                        (1,2)
GO

INSERT INTO ShoppingCartGame(ID, ShoppingCartID, GameID) VALUES
                                (1,1,2)
GO
INSERT INTO [Order](ID, ShoppingCartID, isSuccessfull, TotalCost, PaidCost, DateCreated) VALUES
                    (1,1,1,40,30,'2022-07-03 01:00:00')

GO
INSERT INTO Friendship(ID, RequesterID, RecieverID, isAccepted, RequestedDate, AcceptedDate) VALUES
                        (1,2,3,1,'2020-01-01 00:00:00','2020-01-02 00:00:00')
GO

INSERT INTO Comment(CommentID, UserID, GameID, Score, Title, Text, CreationDate)
VALUES 
					(1, 2, 2, 5, 'AWLIE', 'IN MAH SHARE', '2020-03-20 08:20:00'),
					(2, 3, 3, 4, 'KHOB', 'KHOBE', '2019-03-20 08:20:00')

GO

INSERT INTO Offer(OfferID,DiscountPercentage,DueTime,GameID) VALUES
					(1,20,'2022-07-05 00:00:00',2)

GO
INSERT INTO UserGame(ID,GameID,UserID,HoursPlayed) VALUES
					(2,1,2,0)