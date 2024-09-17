USE [MZS]
GO

/****** Object:  Table [dbo].[TransactionDetails]    Script Date: 9/17/2024 11:43:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TransactionDetails](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[Debit] [float] NOT NULL,
	[Credit] [float] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[Note] [varchar](500) NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy] [int] NULL,
	[DateLastUpdated] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TransactionDetails] ADD  DEFAULT ((0)) FOR [Debit]
GO

ALTER TABLE [dbo].[TransactionDetails] ADD  DEFAULT ((0)) FOR [Credit]
GO


