﻿CREATE TABLE [dbo].[Movies]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Title] NVARCHAR(200) NULL, 
    [Plot] NVARCHAR(MAX) NULL
)