

CREATE TABLE Users (
    userId CHAR(10) PRIMARY KEY,
    EncryptedPass char(25),
    Affiliation char(20)
);

CREATE TABLE Trip (
    Tid char(10) PRIMARY KEY,
    Loc char(40)
);

CREATE TABLE Friend (
    friend1 char(10),
    friend2 char(10),
    FOREIGN KEY (friend1) REFERENCES Users(userId),
    FOREIGN KEY (friend2) REFERENCES Users(userId),
    CHECK (friend1 <> friend2)
);

CREATE TABLE Albums (
    Tid char(10),
    Aid char(10),
    Name char(10),
    PRIMARY KEY (Tid, Aid),
    FOREIGN KEY (Tid) REFERENCES Trip(Tid)
);

CREATE TABLE Photos (
    Tid char(10),
    Aid char(10),
    Pid char(10),
    Url char(100),
    PRIMARY KEY (Tid, Aid, Pid),
    FOREIGN KEY (Tid, Aid) REFERENCES Albums(Tid, Aid)
);

CREATE TABLE Videos (
    Tid char(10),
    Aid char(10),
    Vid char(10),
    Url char(100),
    PRIMARY KEY (Tid, Aid, Vid),
    FOREIGN KEY (Tid, Aid) REFERENCES Albums(Tid, Aid)
);

CREATE TABLE Items (
    Tid char(10),
    Name CHAR(30),
    Count INTEGER,
    PRIMARY KEY (Tid, Name),
    FOREIGN KEY (Tid) REFERENCES Trip(Tid)
);

CREATE TABLE CommentPhotos (
    Tid char(10),
    Aid char(10),
    Pid char(10),
    userId char(10),
    txt char(999),
    PRIMARY KEY(Tid, Aid, Pid, userId),
    FOREIGN KEY (Tid, Aid, Pid) REFERENCES Photos(Tid, Aid, Pid),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE CommentTrip (
    Tid char(10),
    userId char(10),
    txt char(999),
    PRIMARY KEY (Tid, userId),
    FOREIGN KEY (Tid) REFERENCES Trip(Tid),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE RateTrip (
    Tid char(10),
    userId char(10),
    Rating INTEGER,
    FOREIGN KEY (Tid) REFERENCES Trip(Tid),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE WentOn(
    Tid char(10),
    userId char(10),
    FOREIGN KEY (Tid) REFERENCES Trip(Tid),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE Invite (
    Inviter char(10),
    Invitee char(10),
    Tid char(10),
    FOREIGN KEY (Inviter) REFERENCES Users(userId),
    FOREIGN KEY (Invitee) REFERENCES Users(userId),
    FOREIGN KEY (Tid) REFERENCES Trip(Tid),
    CHECK (Inviter <> Invitee)
);

CREATE TABLE ShareVideos (
    Sharer char(10),
    Sharee char(10),
    Tid char(10),
    Aid char(10),
    Vid char(10),
    FOREIGN KEY (Sharer) REFERENCES Users(userId),
    FOREIGN KEY (Sharee) REFERENCES Users(userId),
    FOREIGN KEY (Tid, Aid, Vid) REFERENCES Videos(Tid, Aid, Vid),
    CHECK (Sharer <> Sharee)
);

CREATE TABLE SharePhotos (
    Sharer char(10),
    Sharee char(10),
    Tid char(10),
    Aid char(10),
    Pid char(10),
    FOREIGN KEY (Sharer) REFERENCES Users(userId),
    FOREIGN KEY (Sharee) REFERENCES Users(userId),
    FOREIGN KEY (Tid, Aid, Pid) REFERENCES Photos(Tid, Aid, Pid),
    CHECK (Sharer <> Sharee)
);



