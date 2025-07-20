-- 健康步道应用程序数据库设计
-- Create db
CREATE DATABASE HealthTrailApp;
GO

USE HealthTrailApp;
GO

-- Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('User', 'Admin')),
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastLoginDate DATETIME,
    IsActive BIT DEFAULT 1
);

-- 2. Admins
CREATE TABLE Admins (
    AdminID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    AdminLevel NVARCHAR(20) NOT NULL CHECK (AdminLevel IN ('SuperAdmin', 'TrailAdmin', 'RegularAdmin')),
    Department NVARCHAR(50),
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- 3. Locations
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    LocationName NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Latitude DECIMAL(10,8),
    Longitude DECIMAL(11,8),
    Description NVARCHAR(255),
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- 4. Trails
CREATE TABLE Trails (
    TrailID INT PRIMARY KEY IDENTITY(1,1),
    TrailName NVARCHAR(100) NOT NULL,
    LocationID INT NOT NULL,
    Distance DECIMAL(5,2) NOT NULL,
    Difficulty NVARCHAR(20) NOT NULL CHECK (Difficulty IN ('Easy', 'Medium', 'Hard')),
    EstimatedTime INT, -- 预计时间（分钟）
    Description NVARCHAR(500),
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- 5. Reviews
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    TrailID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
    Comment NVARCHAR(500),
    ReviewDate DATETIME DEFAULT GETDATE(),
    IsVerified BIT DEFAULT 0,
    FOREIGN KEY (TrailID) REFERENCES Trails(TrailID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- 6. Weather
CREATE TABLE Weather (
    WeatherID INT PRIMARY KEY IDENTITY(1,1),
    LocationID INT NOT NULL,
    Date DATE NOT NULL,
    Temperature DECIMAL(5,2),
    Humidity INT,
    WeatherCondition NVARCHAR(50),
    WindSpeed DECIMAL(5,2),
    Precipitation DECIMAL(5,2),
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- 插入测试数据
-- 1. insert users
INSERT INTO Users (Username, Email, Password, Role) VALUES
('Grace Hopper', 'grace@plymouth.ac.uk', 'ISAD123!', 'Admin'),
('Tim Berners-Lee', 'tim@plymouth.ac.uk', 'COMP2001!', 'Admin'),
('Ada Lovelace', 'ada@plymouth.ac.uk', 'insecurePassword', 'User'),
('John Smith', 'john.smith@email.com', 'Password123!', 'User'),
('Mary Johnson', 'mary.johnson@email.com', 'SecurePass456!', 'User'),
('David Brown', 'david.brown@email.com', 'MyPass789!', 'User'),
('Sarah Wilson', 'sarah.wilson@email.com', 'StrongPass321!', 'Admin'),
('Mike Davis', 'mike.davis@email.com', 'AdminPass654!', 'Admin'),
('Lisa Garcia', 'lisa.garcia@email.com', 'UserPass987!', 'User'),
('Tom Martinez', 'tom.martinez@email.com', 'TrailPass147!', 'User');

select * from Users;

-- 2. insert Admins
INSERT INTO Admins (UserID, AdminLevel, Department) VALUES
(1, 'SuperAdmin', 'System Management'),
(2, 'TrailAdmin', 'Trail Management'),
(7, 'RegularAdmin', 'User Support'),
(8, 'TrailAdmin', 'Trail Maintenance'),
(1, 'SuperAdmin', 'Database Management'),
(2, 'TrailAdmin', 'Content Management'),
(7, 'RegularAdmin', 'Customer Service'),
(8, 'TrailAdmin', 'Safety Management'),
(1, 'SuperAdmin', 'System Security'),
(2, 'RegularAdmin', 'Data Analysis');

select * from Admins

-- 3. Insert Locations
INSERT INTO Locations (LocationName, City, Country, Latitude, Longitude, Description) VALUES
('Central Park', 'New York', 'USA', 40.7829, -73.9654, 'Famous urban park in Manhattan'),
('Hyde Park', 'London', 'UK', 51.5074, -0.1278, 'Historic park in central London'),
('Golden Gate Park', 'San Francisco', 'USA', 37.7694, -122.4862, 'Large urban park near Golden Gate Bridge'),
('Regent''s Park', 'London', 'UK', 51.5313, -0.1564, 'Royal park in northwest London'),
('Yosemite Valley', 'California', 'USA', 37.7459, -119.5936, 'Stunning valley in Yosemite National Park'),
('Lake District', 'Cumbria', 'UK', 54.4609, -3.0886, 'Beautiful lake region in England'),
('Banff National Park', 'Alberta', 'Canada', 51.4968, -115.9281, 'Mountain wilderness in Canadian Rockies'),
('Yellowstone', 'Wyoming', 'USA', 44.4280, -110.5885, 'America''s first national park'),
('Peak District', 'Derbyshire', 'UK', 53.3498, -1.8154, 'Upland area in central England'),
('Great Smoky Mountains', 'Tennessee', 'USA', 35.6118, -83.4895, 'Mountain range on Tennessee-North Carolina border');

select * from Locations

-- 4. insert Trails
INSERT INTO Trails (TrailName, LocationID, Distance, Difficulty, EstimatedTime, Description) VALUES
('Reservoir Loop', 1, 2.5, 'Easy', 45, 'Peaceful loop around Central Park reservoir'),
('Hyde Park Circuit', 2, 3.0, 'Easy', 55, 'Complete circuit of Hyde Park with landmarks'),
('Golden Gate Trail', 3, 4.2, 'Medium', 90, 'Trail connecting to Golden Gate Bridge views'),
('Primrose Hill Walk', 4, 1.8, 'Easy', 30, 'Short walk to panoramic London views'),
('Mist Trail', 5, 8.5, 'Hard', 240, 'Challenging trail to Vernal Fall'),
('Helvellyn Ridge', 6, 12.0, 'Hard', 360, 'Classic Lake District mountain hike'),
('Lake Louise Loop', 7, 3.5, 'Medium', 75, 'Scenic loop around famous turquoise lake'),
('Old Faithful Trail', 8, 2.0, 'Easy', 40, 'Easy walk to famous geyser'),
('Kinder Scout', 9, 10.0, 'Hard', 300, 'Challenging moorland plateau hike'),
('Cataract Falls', 10, 6.0, 'Medium', 150, 'Beautiful waterfall trail');

select * from Trails

-- 5. insert Reviews
INSERT INTO Reviews (TrailID, UserID, Rating, Comment) VALUES
(1, 3, 5, 'Beautiful peaceful walk, perfect for morning exercise'),
(1, 4, 4, 'Great views of the city, can get crowded on weekends'),
(2, 5, 5, 'Love the historic feel of this park, very well maintained'),
(3, 6, 4, 'Amazing views of the Golden Gate Bridge, moderate difficulty'),
(4, 7, 3, 'Nice short walk but very crowded with tourists'),
(5, 8, 5, 'Challenging but absolutely worth it for the waterfall views'),
(6, 9, 4, 'Tough hike but spectacular mountain scenery'),
(7, 10, 5, 'Stunning lake views, well-marked trail'),
(8, 3, 4, 'Easy family-friendly walk, educational too'),
(9, 4, 5, 'Challenging moorland hike with great sense of achievement');

select * from Reviews

-- 6. insert Weather
INSERT INTO Weather (LocationID, Date, Temperature, Humidity, WeatherCondition, WindSpeed, Precipitation) VALUES
(1, '2024-07-01', 25.5, 65, 'Sunny', 8.2, 0.0),
(2, '2024-07-01', 18.3, 72, 'Partly Cloudy', 12.5, 0.0),
(3, '2024-07-01', 22.1, 68, 'Foggy', 15.8, 0.0),
(4, '2024-07-01', 17.9, 74, 'Overcast', 10.3, 2.1),
(5, '2024-07-01', 28.7, 45, 'Clear', 6.4, 0.0),
(6, '2024-07-01', 15.2, 78, 'Rainy', 18.9, 8.5),
(7, '2024-07-01', 12.8, 55, 'Snow', 22.1, 5.2),
(8, '2024-07-01', 26.4, 40, 'Sunny', 7.8, 0.0),
(9, '2024-07-01', 16.7, 82, 'Misty', 25.3, 1.8),
(10, '2024-07-01', 24.3, 58, 'Partly Cloudy', 9.7, 0.0);

select * from Weather

-- Views
CREATE VIEW vw_TrailDetails AS
SELECT 
    t.TrailID,
    t.TrailName,
    l.LocationName,
    l.City,
    l.Country,
    t.Distance,
    t.Difficulty,
    t.EstimatedTime,
    t.Description,
    AVG(CAST(r.Rating AS FLOAT)) AS AverageRating,
    COUNT(r.ReviewID) AS ReviewCount,
    t.CreatedDate
FROM Trails t
INNER JOIN Locations l ON t.LocationID = l.LocationID
LEFT JOIN Reviews r ON t.TrailID = r.TrailID
WHERE t.IsActive = 1
GROUP BY t.TrailID, t.TrailName, l.LocationName, l.City, l.Country, 
         t.Distance, t.Difficulty, t.EstimatedTime, t.Description, t.CreatedDate;

select * from vw_TrailDetails

CREATE VIEW vw_UserActivity AS
SELECT 
    u.UserID,
    u.Username,
    u.Email,
    u.Role,
    COUNT(r.ReviewID) AS ReviewCount,
    AVG(CAST(r.Rating AS FLOAT)) AS AverageRatingGiven,
    MAX(r.ReviewDate) AS LastReviewDate,
    u.LastLoginDate
FROM Users u
LEFT JOIN Reviews r ON u.UserID = r.UserID
WHERE u.IsActive = 1
GROUP BY u.UserID, u.Username, u.Email, u.Role, u.LastLoginDate;

select * from vw_UserActivity

-- Retrieve trails with specified difficulty
CREATE PROCEDURE sp_GetTrailsByDifficulty
    @Difficulty NVARCHAR(20)
AS
BEGIN
    SELECT 
        t.TrailID,
        t.TrailName,
        l.LocationName,
        l.City,
        t.Distance,
        t.EstimatedTime,
        AVG(CAST(r.Rating AS FLOAT)) AS AverageRating
    FROM Trails t
    INNER JOIN Locations l ON t.LocationID = l.LocationID
    LEFT JOIN Reviews r ON t.TrailID = r.TrailID
    WHERE t.Difficulty = @Difficulty AND t.IsActive = 1
    GROUP BY t.TrailID, t.TrailName, l.LocationName, l.City, t.Distance, t.EstimatedTime
    ORDER BY AverageRating DESC;
END;

EXEC sp_GetTrailsByDifficulty 'Easy';

-- Add a new trail review
CREATE PROCEDURE sp_AddTrailReview
    @TrailID INT,
    @UserID INT,
    @Rating INT,
    @Comment NVARCHAR(500)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check if the user has already reviewed this trail
        IF EXISTS (SELECT 1 FROM Reviews WHERE TrailID = @TrailID AND UserID = @UserID)
        BEGIN
            ROLLBACK TRANSACTION;
            RAISERROR('User has already reviewed this trail.', 16, 1);
            RETURN;
        END
        
        -- insert
        INSERT INTO Reviews (TrailID, UserID, Rating, Comment)
        VALUES (@TrailID, @UserID, @Rating, @Comment);
        
        COMMIT TRANSACTION;
        
        SELECT 'Review added successfully.' AS Result;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

EXEC sp_AddTrailReview @TrailID = 1, @UserID = 5, @Rating = 4, @Comment = 'Great trail for beginners!';

select * from Reviews where TrailID = 1 and UserID = 5


-- When attempting to delete a trail, block the deletion if there are reviews associated with it
CREATE TRIGGER tr_PreventTrailDeletion
ON Trails
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TrailID INT;
    DECLARE @ReviewCount INT;
    
    -- Check each trail to be deleted
    DECLARE trail_cursor CURSOR FOR
    SELECT TrailID FROM deleted;
    
    OPEN trail_cursor;
    FETCH NEXT FROM trail_cursor INTO @TrailID;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Check if there are any reviews
        SELECT @ReviewCount = COUNT(*) FROM Reviews WHERE TrailID = @TrailID;
        
        IF @ReviewCount > 0
        BEGIN
            -- If there are reviews, mark it as inactive instead of deleting
            UPDATE Trails SET IsActive = 0 WHERE TrailID = @TrailID;
            PRINT 'Trail ' + CAST(@TrailID AS VARCHAR(10)) + ' has reviews and has been marked as inactive.';
        END
        ELSE
        BEGIN
            -- If there are no reviews, it can be safely deleted
            DELETE FROM Trails WHERE TrailID = @TrailID;
            PRINT 'Trail ' + CAST(@TrailID AS VARCHAR(10)) + ' has been successfully deleted.';
        END
        
        FETCH NEXT FROM trail_cursor INTO @TrailID;
    END
    
    CLOSE trail_cursor;
    DEALLOCATE trail_cursor;
END;

-- Attempt to delete a trail with reviews
DELETE FROM Trails WHERE TrailID = 1;
