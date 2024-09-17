USE [MZS]
GO

/****** Object:  Table [dbo].[Account]    Script Date: 9/17/2024 11:41:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Account](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](100) NULL,
	[Description] [varchar](500) NULL,
	[isClosed] [tinyint] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy] [int] NULL,
	[DateLastUpdated] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [isClosed]
GO


