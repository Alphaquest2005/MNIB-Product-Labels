USE [master]
GO
/****** Object:  Database [MNIBTrackerDB]    Script Date: 3/17/2017 12:16:22 PM ******/
CREATE DATABASE [MNIBTrackerDB] ON  PRIMARY 
( NAME = N'MNIBTrackerDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\MNIBTrackerDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MNIBTrackerDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\MNIBTrackerDB_log.ldf' , SIZE = 3072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MNIBTrackerDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MNIBTrackerDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MNIBTrackerDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MNIBTrackerDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MNIBTrackerDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MNIBTrackerDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MNIBTrackerDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MNIBTrackerDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MNIBTrackerDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MNIBTrackerDB] SET  MULTI_USER 
GO
ALTER DATABASE [MNIBTrackerDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MNIBTrackerDB] SET DB_CHAINING OFF 
GO
USE [MNIBTrackerDB]
GO
/****** Object:  Table [dbo].[PO2SalesItemDescription]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PO2SalesItemDescription](
	[POItemDescription] [varchar](50) NOT NULL,
	[SalesItemDescription] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PO2SalesItemDescription] PRIMARY KEY CLUSTERED 
(
	[POItemDescription] ASC,
	[SalesItemDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TransactionDetails]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransactionDetails](
	[TransactionNo] [varchar](50) NOT NULL,
	[LotNumber] [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[TransactionDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TransactionDetails] PRIMARY KEY CLUSTERED 
(
	[TransactionDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[PurchaseOrderDetails]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PurchaseOrderDetails]
AS
SELECT        REPLACE(PO_RECVR_HIST_LIN.RECVR_NO, '-', '') + '0' + CAST(PO_RECVR_HIST_LIN.SEQ_NO AS varchar(10)) AS LotNumber, 
                         PO_RECVR_HIST_LIN.RECVR_NO AS PurchaseOrderNo, PO_RECVR_HIST_LIN.SEQ_NO AS LineNumber, PO_RECVR_HIST_LIN.ITEM_NO AS ItemNumber, 
                         PO_RECVR_HIST_LIN.ITEM_DESCR AS ItemDescription, PO_RECVR_HIST_LIN.QTY_RECVD AS Quantity, PO_RECVR_HIST_LIN.QTY_UNIT AS Unit, 
                         PO_RECVR_HIST_LIN.RECVD_EXT_COST AS Cost, PO_RECVR_HIST_LIN.CATEG_COD, PO_RECVR_HIST_LIN.SUBCAT_COD, 
                         PO_RECVR_HIST.RECVR_LOC_ID AS LocationCode, PO_RECVR_HIST.RECVR_DAT AS PurchaseOrderDate, PO_RECVR_HIST.VEND_NAM AS VendorName
FROM            MNIB.dbo.PO_RECVR_HIST_LIN AS PO_RECVR_HIST_LIN WITH (nolock) INNER JOIN
                         MNIB.dbo.PO_RECVR_HIST AS PO_RECVR_HIST WITH (nolock) ON PO_RECVR_HIST_LIN.RECVR_NO = PO_RECVR_HIST.RECVR_NO
WHERE        (PO_RECVR_HIST_LIN.CATEG_COD = 'fprod') AND (PO_RECVR_HIST.RECVR_DAT > CONVERT(DATETIME, '2015-01-01 00:00:00', 102))

GO
/****** Object:  View [dbo].[GunData]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GunData]
AS
SELECT dbo.TransactionDetails.TransactionNo, dbo.TransactionDetails.LotNumber, dbo.TransactionDetails.Quantity, dbo.TransactionDetails.TransactionDateTime, dbo.PurchaseOrderDetails.ItemDescription, dbo.PurchaseOrderDetails.PurchaseOrderDate, 
             dbo.PurchaseOrderDetails.Unit, dbo.PurchaseOrderDetails.CATEG_COD, dbo.PurchaseOrderDetails.SUBCAT_COD
FROM   dbo.TransactionDetails LEFT OUTER JOIN
             dbo.PurchaseOrderDetails ON dbo.TransactionDetails.LotNumber = dbo.PurchaseOrderDetails.LotNumber


GO
/****** Object:  View [dbo].[UnknownGunData]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UnknownGunData]
AS
SELECT        dbo.TransactionDetails.TransactionNo, dbo.TransactionDetails.LotNumber, dbo.TransactionDetails.Quantity, dbo.TransactionDetails.TransactionDateTime, 
                         dbo.PurchaseOrderDetails.ItemDescription, dbo.PurchaseOrderDetails.PurchaseOrderDate, dbo.PurchaseOrderDetails.Unit, dbo.PurchaseOrderDetails.CATEG_COD, 
                         dbo.PurchaseOrderDetails.SUBCAT_COD
FROM            dbo.TransactionDetails LEFT OUTER JOIN
                         dbo.PurchaseOrderDetails ON dbo.TransactionDetails.LotNumber = dbo.PurchaseOrderDetails.LotNumber
WHERE        (dbo.PurchaseOrderDetails.LotNumber IS NULL)


GO
/****** Object:  View [dbo].[CounterPointSales]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CounterPointSales]
AS
SELECT        PS_TKT_HIST_1.TKT_NO AS InvoiceNo, PS_TKT_HIST_1.TKT_DT AS InvoiceDate, PS_TKT_HIST_1.TAX_AMT AS Tax, PS_TKT_HIST_1.PRC_LOC_ID AS LocationCode,
                          MNIB.dbo.AR_CUST.NAM AS CustomerNo
FROM            MNIB.dbo.PS_TKT_HIST AS PS_TKT_HIST_1 WITH (noLock) LEFT OUTER JOIN
                         MNIB.dbo.AR_CUST ON PS_TKT_HIST_1.CUST_NO = MNIB.dbo.AR_CUST.CUST_NO
WHERE        (PS_TKT_HIST_1.PRC_LOC_ID = 'RRPH') AND (PS_TKT_HIST_1.TKT_DT > CONVERT(DATETIME, '2015-01-01 00:00:00', 102))

GO
/****** Object:  View [dbo].[TransferHeader]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TransferHeader]
AS
/*SELECT        XFER_NO AS TransferNo, RECVD_DAT AS TransferDate, FROM_LOC_ID AS FromLocation, TO_LOC_ID AS ToLocation
FROM            MNIB.dbo.IM_XFER_IN_HIST AS IM_XFER_IN_HIST WITH (nolock)
WHERE        RECVD_DAT > '1/1/2015'
UNION*/
SELECT        XFER_NO AS TransferNo, RECVD_DAT AS TransferDate, FROM_LOC_ID AS FromLocation, TO_LOC_ID AS ToLocation
FROM            MNIB.dbo.IM_XFER_IN_HDR AS IM_XFER_IN_HDR WITH (nolock)
WHERE        RECVD_DAT > '1/1/2015'
UNION
SELECT        XFER_NO AS TransferNo, SHIP_DAT AS TransferDate, FROM_LOC_ID AS FromLocation, TO_LOC_ID AS ToLocation
FROM            MNIB.dbo.IM_XFER_HDR AS IM_XFER_HDR WITH (nolock)
WHERE        SHIP_DAT > '1/1/2015'

GO
/****** Object:  View [dbo].[UnknownGunTransactionsBkp]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[UnknownGunTransactionsBkp]
AS
SELECT        dbo.TransactionDetails.TransactionNo, dbo.TransactionDetails.LotNumber, dbo.TransactionDetails.Quantity, dbo.TransactionDetails.TransactionDateTime, 
                         dbo.PurchaseOrderDetails.ItemDescription
FROM            dbo.CounterPointSales RIGHT OUTER JOIN
                         dbo.TransactionDetails LEFT OUTER JOIN
                         dbo.PurchaseOrderDetails ON dbo.TransactionDetails.LotNumber = dbo.PurchaseOrderDetails.LotNumber LEFT OUTER JOIN
                         dbo.TransferHeader ON dbo.PurchaseOrderDetails.PurchaseOrderDate <= dbo.TransferHeader.TransferDate AND 
                         dbo.TransactionDetails.TransactionNo = dbo.TransferHeader.TransferNo ON 
                         dbo.CounterPointSales.InvoiceDate >= dbo.PurchaseOrderDetails.PurchaseOrderDate AND 
                         dbo.CounterPointSales.InvoiceNo = dbo.TransactionDetails.TransactionNo
WHERE        (dbo.TransferHeader.TransferNo IS NULL) AND (dbo.CounterPointSales.InvoiceNo IS NULL)



GO
/****** Object:  View [dbo].[PurchaseOrder]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PurchaseOrder]
AS
SELECT        PO_RECVR_HIST.RECVR_NO AS PONumber, PO_RECVR_HIST.RECVR_DAT AS PODate, PO_RECVR_HIST.VEND_NAM AS Vendor, 
                         PO_RECVR_HIST.VEND_NO AS VendorNo, IM_LOC.DESCR AS Location, PO_RECVR_HIST.RECVR_LOC_ID AS LocationCode
FROM            MNIB.dbo.PO_RECVR_HIST AS PO_RECVR_HIST WITH (nolock) INNER JOIN
                         MNIB.dbo.IM_LOC AS IM_LOC WITH (nolock) ON PO_RECVR_HIST.RECVR_LOC_ID = IM_LOC.LOC_ID
WHERE        (PO_RECVR_HIST.RECVR_DAT > CONVERT(DATETIME, '2015-01-01 00:00:00', 102))

GO
/****** Object:  View [dbo].[DailyPODetails]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DailyPODetails]
AS
SELECT dbo.PurchaseOrder.PONumber, dbo.PurchaseOrder.PODate, dbo.PurchaseOrderDetails.LotNumber, dbo.PurchaseOrder.LocationCode, dbo.PurchaseOrder.Vendor AS VendorNo, dbo.PurchaseOrderDetails.ItemDescription, dbo.PurchaseOrderDetails.Unit, 
             dbo.PurchaseOrderDetails.Quantity AS TrackedQuantity, dbo.PurchaseOrder.PODate AS TrackedDateTime, dbo.PurchaseOrderDetails.CATEG_COD AS Category, dbo.PurchaseOrderDetails.SUBCAT_COD AS SubCategory, 'Purchases' AS Type
FROM   dbo.PurchaseOrderDetails INNER JOIN
             dbo.PurchaseOrder ON dbo.PurchaseOrderDetails.PurchaseOrderNo = dbo.PurchaseOrder.PONumber
WHERE (dbo.PurchaseOrderDetails.CATEG_COD = 'FPROD')


GO
/****** Object:  View [dbo].[DailyTransfersRecieved]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DailyTransfersRecieved]
AS
SELECT        dbo.TransferHeader.TransferNo, dbo.TransferHeader.TransferDate, dbo.GunData.LotNumber, dbo.TransferHeader.ToLocation AS LocationCode, 
                         dbo.TransferHeader.FromLocation, dbo.GunData.ItemDescription, dbo.GunData.Unit, dbo.GunData.Quantity AS TrackedQuantity, 
                         dbo.GunData.TransactionDateTime AS TrackedDateTime, dbo.GunData.CATEG_COD, dbo.GunData.SUBCAT_COD, 'TransfersIn' AS Type, 
                         dbo.GunData.PurchaseOrderDate
FROM            dbo.TransferHeader INNER JOIN
                         dbo.GunData ON dbo.TransferHeader.TransferNo = dbo.GunData.TransactionNo


GO
/****** Object:  View [dbo].[DailyTransfersOut]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DailyTransfersOut]
AS
SELECT        dbo.TransferHeader.TransferNo, dbo.TransferHeader.TransferDate, dbo.GunData.LotNumber, dbo.TransferHeader.FromLocation AS LocationCode, 
                         dbo.TransferHeader.ToLocation, dbo.GunData.ItemDescription, dbo.GunData.Unit, dbo.GunData.Quantity * - 1 AS TrackedQuantity, 
                         dbo.GunData.TransactionDateTime AS TrackedDateTime, dbo.GunData.CATEG_COD, dbo.GunData.SUBCAT_COD, 'TransfersOut' AS Type, 
                         dbo.GunData.PurchaseOrderDate
FROM            dbo.TransferHeader INNER JOIN
                         dbo.GunData ON dbo.TransferHeader.TransferNo = dbo.GunData.TransactionNo


GO
/****** Object:  View [dbo].[DailySalesDetails]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DailySalesDetails]
AS
SELECT        dbo.CounterPointSales.InvoiceNo, dbo.CounterPointSales.InvoiceDate, dbo.GunData.LotNumber, dbo.CounterPointSales.LocationCode, 
                         dbo.CounterPointSales.CustomerNo, dbo.GunData.ItemDescription, dbo.GunData.Unit, dbo.GunData.Quantity * - 1 AS TrackedQuantity, 
                         dbo.GunData.TransactionDateTime AS TrackedDateTime, dbo.GunData.CATEG_COD, dbo.GunData.SUBCAT_COD, 'Sales' AS Type, 
                         dbo.GunData.PurchaseOrderDate
FROM            dbo.CounterPointSales INNER JOIN
                         dbo.GunData ON dbo.CounterPointSales.InvoiceNo = dbo.GunData.TransactionNo

GO
/****** Object:  View [dbo].[PurchaseReturns]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PurchaseReturns]
AS
SELECT PO_RTV_HIST.RTV_NO AS ReturnNumber, PO_RTV_HIST.RTV_DAT AS ReturnDate, PO_RTV_HIST.VEND_NAM AS Vendor, PO_RTV_HIST.VEND_NO AS VendorNo, IM_LOC.DESCR AS Location, PO_RTV_HIST.RTV_LOC_ID AS LocationCode, PO_RTV_HIST.REF
FROM   MNIB.dbo.PO_RTV_HIST AS PO_RTV_HIST WITH (nolock) INNER JOIN
             MNIB.dbo.IM_LOC AS IM_LOC WITH (nolock) ON PO_RTV_HIST.RTV_LOC_ID = IM_LOC.LOC_ID
WHERE (PO_RTV_HIST.RTV_DAT > CONVERT(DATETIME, '2015-01-01 00:00:00', 102))

GO
/****** Object:  View [dbo].[PurchaseReturnsDetails]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PurchaseReturnsDetails]
AS
SELECT REPLACE(PO_RTV_HIST_LIN.RTV_NO, '-', '') + '0' + CAST(PO_RTV_HIST_LIN.SEQ_NO AS varchar(10)) AS LotNumber, PO_RTV_HIST_LIN.RTV_NO AS ReturnNo, PO_RTV_HIST_LIN.SEQ_NO AS LineNumber, PO_RTV_HIST_LIN.ITEM_NO AS ItemNumber, 
             PO_RTV_HIST_LIN.ITEM_DESCR AS ItemDescription, PO_RTV_HIST_LIN.QTY_RETD AS Quantity, PO_RTV_HIST_LIN.QTY_UNIT AS Unit, PO_RTV_HIST_LIN.EXT_COST AS Cost, PO_RTV_HIST_LIN.CATEG_COD, PO_RTV_HIST_LIN.SUBCAT_COD, 
             PO_RTV_HIST.RTV_LOC_ID AS LocationCode, PO_RTV_HIST.RTV_DAT AS ReturnDate, PO_RTV_HIST.VEND_NAM AS VendorName
FROM   MNIB.dbo.PO_RTV_HIST_LIN AS PO_RTV_HIST_LIN WITH (nolock) INNER JOIN
             MNIB.dbo.PO_RTV_HIST AS PO_RTV_HIST WITH (nolock) ON PO_RTV_HIST_LIN.RTV_NO = PO_RTV_HIST.RTV_NO
WHERE (PO_RTV_HIST_LIN.CATEG_COD = 'fprod') AND (PO_RTV_HIST.RTV_DAT > CONVERT(DATETIME, '2015-01-01 00:00:00', 102))

GO
/****** Object:  View [dbo].[DailyReturns]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DailyReturns]
AS
SELECT dbo.PurchaseReturns.ReturnNumber, dbo.PurchaseReturns.ReturnDate, dbo.PurchaseReturnsDetails.LotNumber, dbo.PurchaseReturns.LocationCode, dbo.PurchaseReturns.Vendor AS VendorNo, dbo.PurchaseReturns.REF AS RefPONumber, 
             dbo.PurchaseReturnsDetails.ItemDescription, dbo.PurchaseReturnsDetails.Unit, dbo.PurchaseReturnsDetails.Quantity AS TrackedQuantity, dbo.PurchaseReturns.ReturnDate AS TrackedDateTime, dbo.PurchaseReturnsDetails.CATEG_COD AS Category, 
             dbo.PurchaseReturnsDetails.SUBCAT_COD AS SubCategory, 'Returns' AS Type
FROM   dbo.PurchaseReturns INNER JOIN
             dbo.PurchaseReturnsDetails ON dbo.PurchaseReturns.ReturnNumber = dbo.PurchaseReturnsDetails.ReturnNo


GO
/****** Object:  View [dbo].[UnknownGunTransactions]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UnknownGunTransactions]
AS
SELECT        GunData.TransactionNo, GunData.LotNumber, GunData.Quantity, GunData.TransactionDateTime, GunData.ItemDescription
FROM            GunData LEFT OUTER JOIN
                         TransferHeader ON GunData.TransactionNo = TransferHeader.TransferNo and  dbo.gundata.PurchaseOrderDate <= dbo.TransferHeader.TransferDate  LEFT OUTER JOIN
                         CounterPointSales ON GunData.TransactionNo = CounterPointSales.InvoiceNo and  dbo.Gundata.PurchaseOrderDate <= dbo.CounterPointSales.InvoiceDate 
WHERE        (TransferHeader.TransferNo IS NULL) AND (CounterPointSales.InvoiceNo IS NULL)

union 

SELECT        TransactionNo, LotNumber, Quantity, TransactionDateTime, ItemDescription
FROM            UnknownGunData


GO
/****** Object:  View [dbo].[CounterPointSalesDetails]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CounterPointSalesDetails]
AS
SELECT        PS_TKT_HIST_1.TKT_NO AS InvoiceNo, PS_TKT_HIST_LIN_1.LIN_SEQ_NO AS LineNumber, PS_TKT_HIST_LIN_1.ITEM_NO AS ItemNumber, 
                         PS_TKT_HIST_LIN_1.DESCR AS ItemDescription, PS_TKT_HIST_LIN_1.QTY_SOLD AS Quantity, PS_TKT_HIST_LIN_1.UNIT_COST AS Cost, 
                         PS_TKT_HIST_1.TKT_DT AS InvoiceDate, PS_TKT_HIST_1.TAX_AMT AS Tax, PS_TKT_HIST_LIN_1.QTY_UNIT AS Unit, 
                         PS_TKT_HIST_1.PRC_LOC_ID AS LocationCode, PS_TKT_HIST_1.CUST_NO AS CustomerNo, dbo.PO2SalesItemDescription.POItemDescription
FROM            dbo.PO2SalesItemDescription INNER JOIN
                         MNIB.dbo.PS_TKT_HIST_LIN AS PS_TKT_HIST_LIN_1 WITH (noLock) ON 
                         dbo.PO2SalesItemDescription.SalesItemDescription = PS_TKT_HIST_LIN_1.DESCR RIGHT OUTER JOIN
                         MNIB.dbo.PS_TKT_HIST AS PS_TKT_HIST_1 WITH (noLock) ON PS_TKT_HIST_LIN_1.DOC_ID = PS_TKT_HIST_1.DOC_ID AND 
                         PS_TKT_HIST_LIN_1.BUS_DAT = PS_TKT_HIST_1.BUS_DAT
WHERE        (PS_TKT_HIST_LIN_1.UNIT_COST IS NOT NULL) AND (PS_TKT_HIST_1.TKT_DT > CONVERT(DATETIME, '2015-01-01 00:00:00', 102))

GO
/****** Object:  View [dbo].[ReconDailySales]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReconDailySales]
AS
SELECT        dbo.CounterPointSalesDetails.InvoiceNo, dbo.CounterPointSalesDetails.ItemDescription, dbo.GunData.LotNumber, SUM(dbo.GunData.Quantity) AS TrackedQty, 
                         SUM(dbo.CounterPointSalesDetails.Quantity) AS TransactionQty, dbo.CounterPointSalesDetails.InvoiceDate, dbo.GunData.PurchaseOrderDate, 
                         ABS(SUM(dbo.CounterPointSalesDetails.Quantity) - SUM(dbo.GunData.Quantity)) AS Variance, CASE WHEN SUM(dbo.CounterPointSalesDetails.Quantity) 
                         < SUM(dbo.gundata.Quantity) THEN 'Short' ELSE 'Overs' END AS Type
FROM            dbo.CounterPointSalesDetails INNER JOIN
                         dbo.GunData ON dbo.CounterPointSalesDetails.InvoiceNo = dbo.GunData.TransactionNo
GROUP BY dbo.CounterPointSalesDetails.InvoiceNo, dbo.CounterPointSalesDetails.ItemDescription, dbo.GunData.LotNumber, dbo.CounterPointSalesDetails.InvoiceDate, 
                         dbo.GunData.PurchaseOrderDate
HAVING        (ABS(SUM(dbo.CounterPointSalesDetails.Quantity) - SUM(dbo.GunData.Quantity)) <> 0)


GO
/****** Object:  View [dbo].[TransferDailyDetails]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TransferDailyDetails]
AS
/*SELECT        IM_XFER_LIN.XFER_NO AS TransferNo, IM_XFER_LIN.XFER_LIN_SEQ_NO AS LineNumber, IM_XFER_LIN.ITEM_NO AS ItemNumber, 
                         IM_XFER_LIN.ITEM_DESCR AS ItemDescription, IM_XFER_LIN.XFER_QTY AS Quantity, IM_XFER_LIN.XFER_UNIT AS Unit, 
                         IM_XFER_LIN.FROM_AVG_COST_BEFORE AS Cost, IM_XFER_IN_HIST.RECVD_DAT AS TransferDate, IM_XFER_IN_HIST.FROM_LOC_ID AS FromLocation, 
                         IM_XFER_IN_HIST.TO_LOC_ID AS ToLocation, IM_XFER_LIN.CATEG_COD AS Category, IM_XFER_LIN.SUBCAT_COD AS SubCategory
FROM            MNIB.dbo.IM_XFER_LIN AS IM_XFER_LIN WITH (nolock) INNER JOIN
                         MNIB.dbo.IM_XFER_IN_HIST AS IM_XFER_IN_HIST WITH (nolock) ON IM_XFER_LIN.XFER_NO = IM_XFER_IN_HIST.XFER_NO
WHERE        IM_XFER_IN_HIST.RECVD_DAT > '1/1/2015'
UNION*/
SELECT        IM_XFER_LIN.XFER_NO AS TransferNo, IM_XFER_LIN.XFER_LIN_SEQ_NO AS LineNumber, IM_XFER_LIN.ITEM_NO AS ItemNumber, 
                         IM_XFER_LIN.ITEM_DESCR AS ItemDescription, IM_XFER_LIN.XFER_QTY AS Quantity, IM_XFER_LIN.XFER_UNIT AS Unit, 
                         IM_XFER_LIN.FROM_AVG_COST_BEFORE AS Cost, IM_XFER_IN_HDR.RECVD_DAT AS TransferDate, IM_XFER_IN_HDR.FROM_LOC_ID AS FromLocation, 
                         IM_XFER_IN_HDR.TO_LOC_ID AS ToLocation, IM_XFER_LIN.CATEG_COD AS Category, IM_XFER_LIN.SUBCAT_COD AS SubCategory
FROM            MNIB.dbo.IM_XFER_LIN AS IM_XFER_LIN WITH (nolock) INNER JOIN
                         MNIB.dbo.IM_XFER_IN_HDR AS IM_XFER_IN_HDR WITH (nolock) ON IM_XFER_LIN.XFER_NO = IM_XFER_IN_HDR.XFER_NO
WHERE        IM_XFER_IN_HDR.RECVD_DAT > '1/1/2015'
UNION
SELECT        IM_XFER_LIN.XFER_NO AS TransferNo, IM_XFER_LIN.XFER_LIN_SEQ_NO AS LineNumber, IM_XFER_LIN.ITEM_NO AS ItemNumber, 
                         IM_XFER_LIN.ITEM_DESCR AS ItemDescription, IM_XFER_LIN.XFER_QTY AS Quantity, IM_XFER_LIN.XFER_UNIT AS Unit, 
                         IM_XFER_LIN.FROM_AVG_COST_BEFORE AS Cost, IM_XFER_HDR.SHIP_DAT AS TransferDate, IM_XFER_HDR.FROM_LOC_ID AS FromLocation, 
                         IM_XFER_HDR.TO_LOC_ID AS ToLocation, IM_XFER_LIN.CATEG_COD AS Category, IM_XFER_LIN.SUBCAT_COD AS SubCategory
FROM            MNIB.dbo.IM_XFER_LIN AS IM_XFER_LIN WITH (nolock) INNER JOIN
                         MNIB.dbo.IM_XFER_HDR AS IM_XFER_HDR WITH (nolock) ON IM_XFER_LIN.XFER_NO = IM_XFER_HDR.XFER_NO
WHERE        IM_XFER_HDR.SHIP_DAT > '1/1/2015'

GO
/****** Object:  View [dbo].[ReconDailyTransfers]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ReconDailyTransfers]
AS
SELECT dbo.TransferDailyDetails.TransferNo, dbo.GunData.ItemDescription, dbo.GunData.LotNumber, SUM(dbo.GunData.Quantity) AS TrackedQty, SUM(dbo.TransferDailyDetails.Quantity) AS TransactionQty, dbo.TransferDailyDetails.TransferDate, 
             dbo.GunData.PurchaseOrderDate, SUM(dbo.TransferDailyDetails.Quantity) - SUM(dbo.GunData.Quantity) AS Variance, CASE WHEN SUM(dbo.transferdailyDetails.Quantity) < SUM(dbo.Gundata.Quantity) THEN 'Short' ELSE 'Overs' END AS Type, 
             dbo.TransferDailyDetails.TransferNo + Right('00' + dbo.TransferDailyDetails.LineNumber, 2) AS Expr1
FROM   dbo.TransferDailyDetails INNER JOIN
             dbo.GunData ON dbo.TransferDailyDetails.TransferNo = dbo.GunData.TransactionNo AND dbo.TransferDailyDetails.ItemDescription = dbo.GunData.ItemDescription
GROUP BY dbo.TransferDailyDetails.TransferNo + Right('00' + dbo.TransferDailyDetails.LineNumber, 2), dbo.TransferDailyDetails.TransferNo, dbo.GunData.ItemDescription, dbo.GunData.LotNumber, dbo.TransferDailyDetails.TransferDate, 
             dbo.GunData.PurchaseOrderDate
HAVING (SUM(dbo.TransferDailyDetails.Quantity) - SUM(dbo.GunData.Quantity) <> 0)


GO
/****** Object:  View [dbo].[ExportData]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ExportData]
AS
SELECT        ExportDate, ReceiptNumber, Harvester, CustomerInfo, ProductNumber, ProductDescription, LineNumber, Weight, ExportNumber, '' AS Expr1, TransactionNumber, 
                         CASE WHEN sourcetransaction = 'Sales Order' THEN 'Exports' WHEN sourcetransaction = 'Invoice' THEN 'Sales' WHEN sourcetransaction = 'Transfer' THEN 'Transfers'
                          ELSE 'Unknown' END AS Type
FROM            MNIBDistributionManager.dbo.ExportReportLines

GO
/****** Object:  View [dbo].[DailyExportDetails]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DailyExportDetails]
AS
SELECT        ExportNumber, ExportDate, CASE WHEN Type = 'Sales Order' THEN LEFT(REPLACE(ReceiptNumber, '-', ''), 14) ELSE LEFT(RIGHT(REPLACE(ReceiptNumber, '-', ''), 
                         9), 8) END AS LotNumber, 'RRPH' AS LocationCode, CustomerInfo AS Vendor, ProductDescription AS ItemDescription, 'LBS' AS Unit, Weight * - 1 AS TrackedQuantity, 
                         ExportDate AS TrackedDateTime, Type
FROM            dbo.ExportData

GO
/****** Object:  View [dbo].[AllDailyTransactions]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AllDailyTransactions]
AS
SELECT        dbo.DailyExportDetails.ExportNumber, dbo.DailyExportDetails.ExportDate, dbo.DailyExportDetails.LotNumber, dbo.DailyExportDetails.LocationCode, dbo.DailyExportDetails. Vendor, 
                         dbo.DailyExportDetails.ItemDescription, dbo.DailyExportDetails.Unit, dbo.DailyExportDetails.TrackedQuantity, dbo.DailyExportDetails.Type
FROM            dbo.DailyExportDetails CROSS JOIN
                         dbo.DailyPODetails
UNION
(SELECT        PONumber, PODate, LotNumber, LocationCode, VendorNo, ItemDescription, Unit, TrackedQuantity, Type
 FROM            DailyPODetails)
UNION
(SELECT        DailyReturns.RefPONumber, DailyReturns.ReturnDate, DailyReturns.LotNumber, DailyReturns.LocationCode, DailyReturns.VendorNo, DailyReturns.ItemDescription, DailyReturns.Unit, 
                         DailyReturns.TrackedQuantity * - 1 AS Expr1, DailyReturns.Type
FROM            DailyReturns INNER JOIN
                         DailyPODetails ON DailyReturns.RefPONumber = DailyPODetails.PONumber)
UNION
(SELECT        InvoiceNo, InvoiceDate, LotNumber, LocationCode, CustomerNo, ItemDescription, Unit, TrackedQuantity*-1, Type
 FROM            DailySalesDetails)
UNION
(SELECT        TransferNo, TransferDate, LotNumber, LocationCode, ToLocation, ItemDescription, Unit, TrackedQuantity*-1, Type
 FROM            DailyTransfersOut)
UNION
(SELECT        TransferNo, TransferDate, LotNumber, LocationCode, FromLocation, ItemDescription, Unit, TrackedQuantity, Type
 FROM            DailyTransfersRecieved)


GO
/****** Object:  View [dbo].[Categories]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Categories]
AS
SELECT        CATEG_COD AS CategoryCode, DESCR_UPR AS Description
FROM            MNIB.dbo.IM_CATEG_COD AS IM_CATEG_COD_1 WITH (nolock)

GO
/****** Object:  View [dbo].[Locations]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Locations]
AS
SELECT        LOC_ID AS LocationCode, DESCR_UPR AS Description
FROM            MNIB.dbo.IM_LOC AS IM_LOC_1 WITH (nolock)

GO
/****** Object:  StoredProcedure [dbo].[GetTransactionActivity]    Script Date: 3/17/2017 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTransactionActivity]
	-- Add the parameters for the stored procedure here
	@StartDate Datetime, 
	@EndDate DateTime,
	@LocationCode varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	create table #TransActivity
	(
		TransactionNo varchar(15), 
		TransactionDate DateTime, 
		LocationCode varchar(10), 
		Contact varchar(40), 
		ItemDescription varchar(50),
		LotNumber varchar(50),
		[Type] varchar(50), 
		Quantity numeric(15,4), 
		[Unit] varchar(15),
		TrackedQty numeric(15,4),
		TrackedDateTime DateTime,
		DateCreated DateTime
	)

    -- Insert statements for procedure here
INSERT INTO [#TransActivity]
SELECT PONumber as TransactionNo, PODate as TransactionDate,LocationCode,VendorNo as Contact, ItemDescription, LotNumber, [Type],TrackedQuantity as Quantity, Unit, TrackedQuantity as TrackedQty, TrackedDateTime,PODate as DateCreated
FROM   DailyPODetails
where (LocationCode = @LocationCode) AND (((PODate >= @StartDate) and (PODate <= @EndDate)))

	
INSERT INTO [#TransActivity]
SELECT TransferNo AS TransactionNo, TransferDate AS TransactionDate, LocationCode, ToLocation AS Contact, ItemDescription, LotNumber, Type, TrackedQuantity AS Quantity, Unit, TrackedQuantity AS TrackedQty, TrackedDateTime, 
             PurchaseOrderDate AS DateCreated
FROM   DailyTransfersOut
where (LocationCode = @LocationCode) AND (((TransferDate >= @StartDate) AND (TransferDate <= @EndDate)) or
										  ((PurchaseOrderDate >= @StartDate) and (PurchaseOrderDate <= @EndDate)))


INSERT INTO [#TransActivity]
SELECT TransferNo AS TransactionNo, TransferDate AS TransactionDate, LocationCode, FromLocation AS Contact, ItemDescription, LotNumber, Type, TrackedQuantity AS Quantity, Unit, TrackedQuantity AS TrackedQty, TrackedDateTime, 
             PurchaseOrderDate AS DateCreated
FROM   DailyTransfersRecieved
 where (LocationCode = @LocationCode) AND (((TransferDate >= @StartDate) AND (TransferDate <= @EndDate)) or
										  ((PurchaseOrderDate >= @StartDate) and (PurchaseOrderDate <= @EndDate)))

INSERT INTO [#TransActivity]
SELECT InvoiceNo AS TransactionNo, InvoiceDate AS TransactionDate, LocationCode, CustomerNo AS Contact, ItemDescription, LotNumber, Type, TrackedQuantity AS Quantity, Unit, TrackedQuantity AS TrackedQty, TrackedDateTime, 
             PurchaseOrderDate AS DateCreated
FROM   DailySalesDetails
WHERE (LocationCode = @LocationCode) AND (((InvoiceDate >= @StartDate) AND (InvoiceDate <= @EndDate)) or
										  ((PurchaseOrderDate >= @StartDate) and (PurchaseOrderDate <= @EndDate)))


select * from #TransActivity

drop table #TransActivity
	
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "IM_CATEG_COD_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 267
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Categories'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Categories'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[12] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PS_TKT_HIST_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 280
               Right = 294
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "AR_CUST (MNIB.dbo)"
            Begin Extent = 
               Top = 9
               Left = 440
               Bottom = 138
               Right = 728
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2835
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2085
         Alias = 2790
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CounterPointSales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CounterPointSales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[16] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PO2SalesItemDescription"
            Begin Extent = 
               Top = 21
               Left = 605
               Bottom = 116
               Right = 804
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PS_TKT_HIST_LIN_1"
            Begin Extent = 
               Top = 6
               Left = 332
               Bottom = 135
               Right = 580
            End
            DisplayFlags = 280
            TopColumn = 16
         End
         Begin Table = "PS_TKT_HIST_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 294
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1005
         Width = 1005
         Width = 1545
         Width = 2775
         Width = 1005
         Width = 1005
         Width = 1740
         Width = 2055
         Width = 555
         Width = 720
         Width = 1065
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CounterPointSalesDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CounterPointSalesDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[30] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ExportData"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 316
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1680
         Width = 1605
         Width = 2385
         Width = 1395
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 8310
         Alias = 2685
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyExportDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyExportDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[28] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PurchaseOrderDetails"
            Begin Extent = 
               Top = 0
               Left = 14
               Bottom = 273
               Right = 300
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "PurchaseOrder"
            Begin Extent = 
               Top = 0
               Left = 597
               Bottom = 260
               Right = 819
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1880
         Width = 2040
         Width = 2990
         Width = 1790
         Width = 2400
         Width = 1010
         Width = 1010
         Width = 1010
         Width = 1010
         Width = 1010
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 9660
         Alias = 1700
         Table = 1970
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyPODetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyPODetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[33] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PurchaseReturnsDetails"
            Begin Extent = 
               Top = 9
               Left = 964
               Bottom = 206
               Right = 1227
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "PurchaseReturns"
            Begin Extent = 
               Top = 0
               Left = 391
               Bottom = 197
               Right = 613
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2680
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyReturns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyReturns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[19] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "GunData"
            Begin Extent = 
               Top = 14
               Left = 383
               Bottom = 143
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "CounterPointSales"
            Begin Extent = 
               Top = 0
               Left = 20
               Bottom = 205
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1965
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3525
         Alias = 2610
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailySalesDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailySalesDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[29] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TransferHeader"
            Begin Extent = 
               Top = 0
               Left = 57
               Bottom = 412
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GunData"
            Begin Extent = 
               Top = 0
               Left = 496
               Bottom = 154
               Right = 698
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1770
         Width = 1005
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3555
         Alias = 1440
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyTransfersOut'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyTransfersOut'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[26] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TransferHeader"
            Begin Extent = 
               Top = 0
               Left = 43
               Bottom = 205
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GunData"
            Begin Extent = 
               Top = 16
               Left = 322
               Bottom = 145
               Right = 524
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1005
         Width = 1005
         Width = 2445
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1275
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3705
         Alias = 2520
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyTransfersRecieved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DailyTransfersRecieved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ExportReportLines (MNIBDistributionManager.dbo)"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 313
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ExportData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ExportData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[35] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TransactionDetails"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PurchaseOrderDetails"
            Begin Extent = 
               Top = 0
               Left = 348
               Bottom = 280
               Right = 539
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2160
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GunData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GunData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "IM_LOC_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2595
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PO_RECVR_HIST"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IM_LOC"
            Begin Extent = 
               Top = 6
               Left = 337
               Bottom = 135
               Right = 554
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1005
         Width = 2445
         Width = 1005
         Width = 1005
         Width = 2805
         Width = 1005
         Width = 1005
         Width = 1005
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5505
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PurchaseOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PurchaseOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PO_RECVR_HIST_LIN"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 231
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PO_RECVR_HIST"
            Begin Extent = 
               Top = 6
               Left = 309
               Bottom = 263
               Right = 570
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 2055
         Width = 1515
         Width = 2025
         Width = 1620
         Width = 2280
         Width = 1635
         Width = 1005
         Width = 1755
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4770
         Alias = 2385
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PurchaseOrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PurchaseOrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[26] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PO_RTV_HIST"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 399
            End
            DisplayFlags = 280
            TopColumn = 44
         End
         Begin Table = "IM_LOC"
            Begin Extent = 
               Top = 9
               Left = 456
               Bottom = 206
               Right = 746
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1810
         Alias = 2630
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PurchaseReturns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PurchaseReturns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PO_RTV_HIST_LIN"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 360
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "PO_RTV_HIST"
            Begin Extent = 
               Top = 9
               Left = 417
               Bottom = 206
               Right = 759
            End
            DisplayFlags = 280
            TopColumn = 31
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4450
         Alias = 2400
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PurchaseReturnsDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PurchaseReturnsDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[28] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -321
         Left = -491
      End
      Begin Tables = 
         Begin Table = "CounterPointSalesDetails"
            Begin Extent = 
               Top = 321
               Left = 946
               Bottom = 526
               Right = 1176
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GunData"
            Begin Extent = 
               Top = 321
               Left = 531
               Bottom = 450
               Right = 749
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1005
         Width = 1005
         Width = 1920
         Width = 1005
         Width = 1005
         Width = 1710
         Width = 2280
         Width = 1005
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 7500
         Alias = 1965
         Table = 2880
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReconDailySales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReconDailySales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[15] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -312
      End
      Begin Tables = 
         Begin Table = "TransferDailyDetails"
            Begin Extent = 
               Top = 0
               Left = 854
               Bottom = 270
               Right = 1223
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "GunData"
            Begin Extent = 
               Top = 0
               Left = 484
               Bottom = 237
               Right = 701
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1010
         Width = 1010
         Width = 1280
         Width = 1010
         Width = 1440
         Width = 1010
         Width = 1010
         Width = 1010
         Width = 1000
         Width = 2070
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 8180
         Alias = 900
         Table = 2600
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReconDailyTransfers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReconDailyTransfers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[17] 4[48] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -192
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 2505
         Width = 1005
         Width = 1005
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 9045
         Alias = 2145
         Table = 3045
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TransferDailyDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TransferDailyDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[16] 4[16] 2[50] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TransferHeader'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TransferHeader'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TransactionDetails"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PurchaseOrderDetails"
            Begin Extent = 
               Top = 9
               Left = 375
               Bottom = 138
               Right = 566
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UnknownGunData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UnknownGunData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[16] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -890
      End
      Begin Tables = 
         Begin Table = "CounterPointSales"
            Begin Extent = 
               Top = 0
               Left = 33
               Bottom = 205
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TransactionDetails"
            Begin Extent = 
               Top = 0
               Left = 975
               Bottom = 205
               Right = 1244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PurchaseOrderDetails"
            Begin Extent = 
               Top = 0
               Left = 1368
               Bottom = 287
               Right = 1625
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TransferHeader"
            Begin Extent = 
               Top = 104
               Left = 266
               Bottom = 309
               Right = 488
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 1005
         Width = 2100
         Width = 1005
         Width = 1005
         Width = 1005
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UnknownGunTransactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UnknownGunTransactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UnknownGunTransactions'
GO
USE [master]
GO
ALTER DATABASE [MNIBTrackerDB] SET  READ_WRITE 
GO
