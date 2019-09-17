CREATE TABLE [dbo].[Movies]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Name] NTEXT NOT NULL, 
    [Plot] NTEXT NULL, 
    [ReleaseYear] INT NULL, 
    [GenreId] INT NOT NULL, 
    CONSTRAINT [FK_Movies_Genres] FOREIGN KEY (GenreId) REFERENCES Genres(Id)
)
