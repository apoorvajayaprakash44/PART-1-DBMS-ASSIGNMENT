USE spotify_streaming;

-- Subscription Plans (3 rows)
INSERT INTO subscription_plan (PlanID, PlanName, MonthlyPrice, MaxDevices, IsFamilyPlan)
VALUES
(1, 'Free', 0.00, 1, 'No'),
(2, 'Premium Individual', 129.00, 3, 'No'),
(3, 'Premium Family', 199.00, 6, 'Yes');

-- Users (2 rows)
INSERT INTO user (UserID, FullName, Email, Phone, Country, DateOfBirth, CreatedAt)
VALUES
(101, 'Apoorva', 'apoorva@example.com', '9876543210', 'India', '2002-08-15', NOW()),
(102, 'Rohan', 'rohan@example.com', '9833221100', 'India', '2001-01-05', NOW());

-- User Subscription (1 row)
INSERT INTO user_subscription (SubscriptionID, UserID, PlanID, StartDate, EndDate, IsActive, AutoRenew)
VALUES
(201, 101, 2, '2025-01-01', NULL, 'Yes', 'Yes');

-- Artist (1 row)
INSERT INTO artist (ArtistID, ArtistName, Country, DebutYear)
VALUES
(301, 'Ed Sheeran', 'UK', 2010);

-- Album (1 row)
INSERT INTO album (AlbumID, ArtistID, AlbumTitle, ReleaseDate, Genre)
VALUES
(401, 301, 'Divide', '2017-03-03', 'Pop');

-- Track (1 row)
INSERT INTO track (TrackID, AlbumID, TrackTitle, DurationSeconds, ExplicitFlag, PopularityScore)
VALUES
(501, 401, 'Shape of You', 235, 'No', 98);

-- Playlist (1 row)
INSERT INTO playlist (PlaylistID, UserID, PlaylistName, IsPublic, CreatedAt)
VALUES
(601, 101, 'My Favorites', 'Yes', NOW());

-- Playlist Track (1 row)
INSERT INTO playlist_track (PlaylistID, TrackID, AddedAt)
VALUES
(601, 501, NOW());

-- Device (1 row)
INSERT INTO device (DeviceID, UserID, DeviceType, OS)
VALUES
(701, 101, 'Mobile', 'Android');

-- Listening Session (1 row)
INSERT INTO listening_session (SessionID, UserID, TrackID, DeviceID, PlayedAt, SecondsPlayed)
VALUES
(801, 101, 501, 701, NOW(), 200);

-- Payment (1 row)
INSERT INTO payment (PaymentID, SubscriptionID, PaymentDate, Amount, PaymentMethod, Status)
VALUES
(901, 201, NOW(), 129.00, 'UPI', 'Success');
