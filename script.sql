USE [master]
GO
/****** Object:  Database [Inventory]    Script Date: 9/7/2016 6:45:46 PM ******/
CREATE DATABASE [Inventory]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Inventory', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Inventory.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Inventory_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Inventory_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Inventory] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Inventory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Inventory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Inventory] SET ARITHABORT OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Inventory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Inventory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Inventory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Inventory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Inventory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Inventory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Inventory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Inventory] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Inventory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Inventory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Inventory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Inventory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Inventory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Inventory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Inventory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Inventory] SET RECOVERY FULL 
GO
ALTER DATABASE [Inventory] SET  MULTI_USER 
GO
ALTER DATABASE [Inventory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Inventory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Inventory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Inventory] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Inventory', N'ON'
GO
USE [Inventory]
GO
/****** Object:  StoredProcedure [dbo].[CreateManifacturer]    Script Date: 9/7/2016 6:45:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[CreateManifacturer]
@ManifacturerName varchar(max),
@ManifacturerAddress varchar(max),
@ManifacturerContact varchar(max)
AS
Begin
insert into Manifacturer
select @ManifacturerName,@ManifacturerAddress,@ManifacturerContact
End;
GO
/****** Object:  StoredProcedure [dbo].[CreateProduct]    Script Date: 9/7/2016 6:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[CreateProduct]
@ProductName varchar(max),
@Price float,
@Category varchar(max),
@Manifacturer varchar(max)
AS
Begin
Declare @Manifacturerid int
select @Manifacturerid=Manifacturerid from Manifacturer where ManifacturerName=@Manifacturer 
if(@Manifacturerid>0)
insert into Product
select @ProductName,@Price,@Category,@Manifacturerid
else
begin
insert into Manifacturer
select @Manifacturer,'',''
select @Manifacturerid=ident_current('Manifacturer')
insert into Product
select @ProductName,@Price,@Category,@Manifacturerid
end;

End;
GO
/****** Object:  StoredProcedure [dbo].[CreateStore]    Script Date: 9/7/2016 6:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[CreateStore]
@StoreName varchar(max),
@StoreAddress varchar(max),
@StoreContact varchar(max)
AS
Begin
insert into Store
select @StoreName,@StoreAddress,@StoreContact
End;
GO
/****** Object:  StoredProcedure [dbo].[GetAllManifacturer]    Script Date: 9/7/2016 6:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAllManifacturer]
As
Begin
select *   from Manifacturer 
End;
GO
/****** Object:  StoredProcedure [dbo].[GetAllProducts]    Script Date: 9/7/2016 6:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetAllProducts]
As
Begin
select ProductId,ProductName,Price,Category,Manifacturer.ManifacturerName as Manifacturer from Product inner join Manifacturer on Product.ManifacturerId=Manifacturer.ManifacturerId
End;
GO
/****** Object:  StoredProcedure [dbo].[GetAllStore]    Script Date: 9/7/2016 6:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAllStore]
As
Begin
select *   from Store 
End;
GO
/****** Object:  Table [dbo].[Manifacturer]    Script Date: 9/7/2016 6:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Manifacturer](
	[ManifacturerId] [int] IDENTITY(1,1) NOT NULL,
	[ManifacturerName] [varchar](max) NULL,
	[ManifacturerAddress] [varchar](max) NULL,
	[ManifacturerContact] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ManifacturerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 9/7/2016 6:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](max) NULL,
	[Price] [float] NULL,
	[Category] [varchar](max) NULL,
	[ManifacturerId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Store]    Script Date: 9/7/2016 6:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Store](
	[StoreId] [int] IDENTITY(1,1) NOT NULL,
	[StoreName] [varchar](max) NULL,
	[StoreAddress] [varchar](max) NULL,
	[StoreContact] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([ManifacturerId])
REFERENCES [dbo].[Manifacturer] ([ManifacturerId])
GO
USE [master]
GO
ALTER DATABASE [Inventory] SET  READ_WRITE 
GO
