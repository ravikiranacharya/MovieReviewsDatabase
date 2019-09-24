CREATE TABLE [dbo].[Genres]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Name] VARCHAR(50) NULL, 
    [Enabled] BIT NULL, 
    [IsDeleted] BIT NULL
)
