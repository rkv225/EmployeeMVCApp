USE [master]
GO
/****** Object:  Database [EmployeeDb]    Script Date: 1/9/2021 9:08:41 PM ******/
CREATE DATABASE [EmployeeDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\EmployeeDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EmployeeDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\EmployeeDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EmployeeDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeeDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeeDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmployeeDb] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmployeeDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EmployeeDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EmployeeDb] SET QUERY_STORE = OFF
GO
USE [EmployeeDb]
GO
/****** Object:  UserDefinedTableType [dbo].[IDList]    Script Date: 1/9/2021 9:08:42 PM ******/
CREATE TYPE [dbo].[IDList] AS TABLE(
	[ID] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
(    
    @Input NVARCHAR(MAX),
    @Character CHAR(1)
)
RETURNS @Output TABLE (
    Item NVARCHAR(1000)
)
AS
BEGIN
    DECLARE @StartIndex INT, @EndIndex INT
 
    SET @StartIndex = 1
    IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
    BEGIN
        SET @Input = @Input + @Character
    END
 
    WHILE CHARINDEX(@Character, @Input) > 0
    BEGIN
        SET @EndIndex = CHARINDEX(@Character, @Input)
         
        INSERT INTO @Output(Item)
        SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
         
        SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
    END
 
    RETURN
END
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeHobbies]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeHobbies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Hobby] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeHobbies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [nvarchar](max) NOT NULL,
	[EmployeeDOB] [datetime2](7) NOT NULL,
	[Gender] [int] NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[StateId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeStates]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeStates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[State] [nvarchar](max) NULL,
 CONSTRAINT [PK_EmployeeStates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT (N'') FOR [EmployeeName]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT (N'') FOR [Address]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_EmployeeStates_StateId] FOREIGN KEY([StateId])
REFERENCES [dbo].[EmployeeStates] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_EmployeeStates_StateId]
GO
/****** Object:  StoredProcedure [dbo].[AddEmployeeHobbies]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddEmployeeHobbies]
(
@Hobbies varchar(255),
@EmpId int
)
AS
BEGIN
  SET NOCOUNT ON;
  INSERT INTO EmployeeHobbies(EmployeeId, Hobby) SELECT @EmpId, CAST(Item AS INTEGER) from dbo.SplitString(@Hobbies, ',');
END
GO
/****** Object:  StoredProcedure [dbo].[AddNewEmployee]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddNewEmployee]
(
	@Name varchar(255),
	@DOB datetime2,
	@Gender int,
	@Address varchar(255),
	@StateId int,
	@Hobbies varchar(255)
)
as
begin
	DECLARE @prefix varchar(5);
	DECLARE @current varchar(50);
	DECLARE @newno int;
	DECLARE @newid varchar(50);
	DECLARE @EmpId int;
	SET @prefix = 'EMP-';
	/*SELECT TOP 1 @current=EmployeeId from Employees order by EmployeeId desc;*/
	/*SET @newno = RIGHT(@current, PATINDEX('%[^0-9]%', @current)-1);*/
	/*SET @newid = CONCAT(@prefix, @newno + 1);*/
	Insert into Employees(EmployeeName, EmployeeDOB, Gender, Address, StateId) values(@Name, @DOB, @Gender, @Address, @StateId);
	SET @EmpId = SCOPE_IDENTITY();
	INSERT INTO EmployeeHobbies(EmployeeId, Hobby) SELECT @EmpId, CAST(Item AS INTEGER) from dbo.SplitString(@Hobbies, ',');
end
GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployees]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllEmployees]
as
begin
	select * from Employees left join EmployeeStates on Employees.StateId = EmployeeStates.Id;
end
GO
/****** Object:  StoredProcedure [dbo].[GetAllStates]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllStates]
as
begin
	select * from EmployeeStates;
end
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeDetail]    Script Date: 1/9/2021 9:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetEmployeeDetail]
(
	@Id int
)
as
begin
	select * from Employees left join EmployeeStates on Employees.StateId = EmployeeStates.Id where EmployeeId = @Id;
end
GO
USE [master]
GO
ALTER DATABASE [EmployeeDb] SET  READ_WRITE 
GO
