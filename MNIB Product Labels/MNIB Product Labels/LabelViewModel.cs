using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Security.RightsManagement;
using System.Text;
using System.Threading;

using System.Windows;
using MNIB_Product_Labels.Properties;


namespace MNIB_Product_Labels
{
    public class LabelViewModel : INotifyPropertyChanged
    {
        private static readonly LabelViewModel instance;
        static LabelViewModel()
        {
            instance = new LabelViewModel();
            
        }

        public static LabelViewModel Instance
        {
            get { return instance; }
        }

        public LabelViewModel()
        {
            PurchaseOrderDetails = new List<PurchaseOrderDetail>();
        }
        public string PONumber { get; set; }

        
        public List<PurchaseOrderDetail> PurchaseOrderDetails { get; set; }
        public PurchaseOrder PurchaseOrder { get; set; }

        public void Search()
        {
            try
            {

                using (var ctx = new MNIBDBDataContext())
                {

                    PurchaseOrder =
                        ctx.PurchaseOrders.FirstOrDefault(x => x.PONumber == PONumber);

                    PurchaseOrderDetails = ctx.PurchaseOrderDetails.Where(x => x.PurchaseOrderNo == PONumber).ToList();

                    //foreach (var p in PurchaseOrderDetails)
                    //{
                    //    p.LabelQty = Convert.ToInt16(p.Quantity/35);
                    //}

                    PONumber = null;

                    OnPropertyChanged("PurchaseOrder");
                    OnPropertyChanged("PurchaseOrderDetails");
                    OnPropertyChanged("PONumber");
                    if (PurchaseOrder == null)
                    {
                        MessageBox.Show("Purchase Order not found. Please try again");
                    }
                }
            }
            catch (SqlException se)
            {
               MessageBox.Show("Problem with the Database. Please contact your System Administrator");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public void Print(List<PurchaseOrderDetail> plst, string labelSize)
        {
            foreach (var itm in plst)
            {
                Print(itm, labelSize);
            }
        }

        public void Print(PurchaseOrderDetail itm, string labelSize)
        {
            switch (labelSize)
                {
                case "Large":
                    PrintLargeSizeLabel(itm);
                    break;
                case "Medium":
                    PrintMediumSizeLabel(itm);
                    break;
                case "Small":
                    PrintSmallSizeLabel(itm);
                    break;
                default:
                    MessageBox.Show("Choose a Paper Size.");
                    break;
                }
            
        }


        private void PrintSmallSizeLabel(PurchaseOrderDetail itm)
        {
            try
            {


                const int VerticalSpace = 75;
                const int HorizontalSpace = 101;
                const string LabelFontSize = "2.5";

                TSCLIB_DLL.openport(Settings.Default.TSCPrinter);                                           //Open specified printer driver
                TSCLIB_DLL.setup("75", "50.2", "6", "8", "1", "5", "0");                           //Setup the media size and sensor type info
                TSCLIB_DLL.clearbuffer();                                                           //Clear image buffer
                TSCLIB_DLL.downloadpcx("box.pcx", "box.pcx");                                         //Download PCX file into printer



                TSCLIB_DLL.printerfont((HorizontalSpace * 0).ToString(), (VerticalSpace * .5).ToString(), "2", "0", LabelFontSize, LabelFontSize, PurchaseOrder.Vendor.Substring(0, PurchaseOrder.Vendor.IndexOf(" ") + 1));

                TSCLIB_DLL.printerfont((HorizontalSpace * 3).ToString(), (VerticalSpace * .5).ToString(), "1", "0", LabelFontSize, LabelFontSize, PurchaseOrder.PODate.ToString("yyyy-MMM-dd"));        //Drawing printer font

                TSCLIB_DLL.printerfont((HorizontalSpace * 0).ToString(), (VerticalSpace * 1.3).ToString(), "2", "0", LabelFontSize, LabelFontSize, "Inv#");
                TSCLIB_DLL.printerfont((HorizontalSpace * 1.2).ToString(), (VerticalSpace * 1.3).ToString(), "2", "0", LabelFontSize, LabelFontSize, itm.PurchaseOrderNo);

                TSCLIB_DLL.printerfont((HorizontalSpace * 0).ToString(), (VerticalSpace * 2).ToString(), "2", "0", LabelFontSize, LabelFontSize, "Item:");
                TSCLIB_DLL.printerfont((HorizontalSpace * 1.5).ToString(), (VerticalSpace * 2).ToString(), "2", "0", LabelFontSize, LabelFontSize, itm.ItemDescription);

                TSCLIB_DLL.barcode((HorizontalSpace * 0).ToString(), (VerticalSpace * 3).ToString(), "128", "75", "0", "0", "7", "7", itm.Barcode); //Drawing barcode

                TSCLIB_DLL.printerfont((HorizontalSpace * 0).ToString(), (VerticalSpace * 4.1).ToString(), "2", "0", "5", "5", itm.Barcode);

                //TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 4.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "SORT");
                //TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 0, VerticalSpace * 4.5, HorizontalSpace * 2, VerticalSpace * 4.5 + 50));

                //TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 5.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "GRADED");
                //TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 5.5, HorizontalSpace * 8, VerticalSpace * 5.5 + 50));

                //TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 6.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "WASH");
                //TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 6.5, HorizontalSpace * 8, VerticalSpace * 6.5 + 50));

                //TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 7.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "CHILLER#");
                //TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 7.5, HorizontalSpace * 8, VerticalSpace * 7.5 + 49));


                TSCLIB_DLL.printlabel("1", itm.LabelQty.ToString());                                                    //Print labels
                TSCLIB_DLL.closeport();
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }
        }
        private void PrintMediumSizeLabel(PurchaseOrderDetail itm)
        {
            try
            {


                const int VerticalSpace = 75;
                const int HorizontalSpace = 101;
                const string LabelFontSize = "2.5";

                TSCLIB_DLL.openport(Settings.Default.TSCPrinter);                                           //Open specified printer driver
                TSCLIB_DLL.setup("101", "50.2", "6", "8", "0", "0", "0");                           //Setup the media size and sensor type info
                TSCLIB_DLL.clearbuffer();                                                           //Clear image buffer
                TSCLIB_DLL.downloadpcx("box.pcx", "box.pcx");                                         //Download PCX file into printer



                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * .5).ToString(), "2", "0", LabelFontSize, LabelFontSize, PurchaseOrder.Vendor);

                TSCLIB_DLL.printerfont((HorizontalSpace * 5).ToString(), (VerticalSpace * 1.3).ToString(), "2", "0", LabelFontSize, LabelFontSize, PurchaseOrder.PODate.ToString("yyyy-MMM-dd"));        //Drawing printer font

                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 1.3).ToString(), "3", "0", LabelFontSize, LabelFontSize, "Inv#");
                TSCLIB_DLL.printerfont((HorizontalSpace * 2).ToString(), (VerticalSpace * 1.3).ToString(), "3", "0", LabelFontSize, LabelFontSize, itm.PurchaseOrderNo);

                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 2).ToString(), "3", "0", LabelFontSize, LabelFontSize, "Item:");
                TSCLIB_DLL.printerfont((HorizontalSpace * 2.3).ToString(), (VerticalSpace * 2).ToString(), "3", "0", LabelFontSize, LabelFontSize, itm.ItemDescription);

                TSCLIB_DLL.barcode((HorizontalSpace * .5).ToString(), (VerticalSpace * 3).ToString(), "128", "75", "0", "0", "9", "8", itm.Barcode); //Drawing barcode

                TSCLIB_DLL.printerfont((HorizontalSpace * 2).ToString(), (VerticalSpace * 4.1).ToString(), "2", "0", "5", "5", itm.Barcode);

                //TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 4.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "SORT");
                //TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 0, VerticalSpace * 4.5, HorizontalSpace * 2, VerticalSpace * 4.5 + 50));

                //TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 5.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "GRADED");
                //TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 5.5, HorizontalSpace * 8, VerticalSpace * 5.5 + 50));

                //TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 6.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "WASH");
                //TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 6.5, HorizontalSpace * 8, VerticalSpace * 6.5 + 50));

                //TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 7.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "CHILLER#");
                //TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 7.5, HorizontalSpace * 8, VerticalSpace * 7.5 + 49));


                TSCLIB_DLL.printlabel("1", itm.LabelQty.ToString());                                                    //Print labels
                TSCLIB_DLL.closeport();
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }
        }

        //private void PrintMediumSizeLabel(PurchaseOrderDetail itm)
        //{
        //    try
        //    {


        //        const int VerticalSpace = 75;
        //        const int HorizontalSpace = 101;
        //        const string LabelFontSize = "2.5";

        //        TSCLIB_DLL.openport(Settings.Default.TSCPrinter);                                           //Open specified printer driver
        //        TSCLIB_DLL.setup("101", "76.2", "6", "8", "0", "0", "0");                           //Setup the media size and sensor type info
        //        TSCLIB_DLL.clearbuffer();                                                           //Clear image buffer
        //        TSCLIB_DLL.downloadpcx("box.pcx", "box.pcx");                                         //Download PCX file into printer



        //        TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * .5).ToString(), "2", "0", LabelFontSize, LabelFontSize, PurchaseOrder.PODate.ToString("yyyy-MMM-dd"));        //Drawing printer font

        //        TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 1.3).ToString(), "3", "0", LabelFontSize, LabelFontSize, "Inv#");
        //        TSCLIB_DLL.printerfont((HorizontalSpace * 4).ToString(), (VerticalSpace * 1.3).ToString(), "3", "0", LabelFontSize, LabelFontSize, itm.PurchaseOrderNo);

        //        TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 2).ToString(), "3", "0", LabelFontSize, LabelFontSize, "Item:");
        //        TSCLIB_DLL.printerfont((HorizontalSpace * 2.3).ToString(), (VerticalSpace * 2).ToString(), "3", "0", LabelFontSize, LabelFontSize, itm.ItemDescription);

        //        TSCLIB_DLL.barcode((HorizontalSpace * .5).ToString(), (VerticalSpace * 3).ToString(), "128", "60", "1", "0", "8", "8", itm.Barcode); //Drawing barcode


        //        TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 4.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "SORT");
        //        TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 4.5, HorizontalSpace * 8, VerticalSpace * 4.5 + 50));

        //        TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 5.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "GRADED");
        //        TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 5.5, HorizontalSpace * 8, VerticalSpace * 5.5 + 50));

        //        TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 6.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "WASH");
        //        TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 6.5, HorizontalSpace * 8, VerticalSpace * 6.5 + 50));

        //        TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 7.5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "CHILLER#");
        //        TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},2,19.2", HorizontalSpace * 4, VerticalSpace * 7.5, HorizontalSpace * 8, VerticalSpace * 7.5 + 49));


        //        TSCLIB_DLL.printlabel("1", itm.LabelQty.ToString());                                                    //Print labels
        //        TSCLIB_DLL.closeport();
        //    }
        //    catch (Exception ex)
        //    {

        //        MessageBox.Show(ex.Message);
        //    }
        //}

        public void PrintLargeSizeLabel(PurchaseOrderDetail itm)
        {
            try
            {


                const int VerticalSpace = 150;
                const int HorizontalSpace = 100;
                const string LabelFontSize = "2.5";

                TSCLIB_DLL.openport(Settings.Default.TSCPrinter);                                           //Open specified printer driver
                TSCLIB_DLL.setup("101", "150", "6", "8", "0", "5", "0");                           //Setup the media size and sensor type info
                TSCLIB_DLL.clearbuffer();                                                           //Clear image buffer
                TSCLIB_DLL.downloadpcx("box.pcx", "box.pcx");                                         //Download PCX file into printer



                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * .2).ToString(), "3", "0", "3", "3", PurchaseOrder.PODate.ToString("yyyy-MMM-dd"));        //Drawing printer font

                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 1).ToString(), "3", "0", LabelFontSize, LabelFontSize, "Invoice#");
                TSCLIB_DLL.printerfont((HorizontalSpace * 4).ToString(), (VerticalSpace * 1).ToString(), "3", "0", LabelFontSize, LabelFontSize, itm.PurchaseOrderNo);

                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 2).ToString(), "3", "0", LabelFontSize, LabelFontSize, "Item:");
                TSCLIB_DLL.printerfont((HorizontalSpace * 2.3).ToString(), (VerticalSpace * 2).ToString(), "3", "0", LabelFontSize, LabelFontSize, itm.ItemDescription);

                TSCLIB_DLL.barcode((HorizontalSpace * .5).ToString(), (VerticalSpace * 2.6).ToString(), "128", "125", "1", "0", "8", "8", itm.Barcode); //Drawing barcode


                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 4).ToString(), "3", "0", LabelFontSize, LabelFontSize, "SORT");
                TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},4,19.2", HorizontalSpace * 4, VerticalSpace * 4, HorizontalSpace * 8, VerticalSpace * 4 + 100));

                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 5).ToString(), "3", "0", LabelFontSize, LabelFontSize, "GRADED");
                TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},4,19.2", HorizontalSpace * 4, VerticalSpace * 5, HorizontalSpace * 8, VerticalSpace * 5 + 100));

                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 6).ToString(), "3", "0", LabelFontSize, LabelFontSize, "WASH");
                TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},4,19.2", HorizontalSpace * 4, VerticalSpace * 6, HorizontalSpace * 8, VerticalSpace * 6 + 100));

                TSCLIB_DLL.printerfont((HorizontalSpace * .5).ToString(), (VerticalSpace * 7).ToString(), "3", "0", LabelFontSize, LabelFontSize, "CHILLER#");
                TSCLIB_DLL.sendcommand(string.Format("BOX {0},{1},{2},{3},4,19.2", HorizontalSpace * 4, VerticalSpace * 7, HorizontalSpace * 8, VerticalSpace * 7 + 100));


                TSCLIB_DLL.printlabel("1", itm.LabelQty.ToString());                                                    //Print labels
                TSCLIB_DLL.closeport();
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }
        }

        private PurchaseOrderDetail currentPurchaseOrderDetail = null;

        public PurchaseOrderDetail CurrentPurchaseOrderDetail
        {
            get { return currentPurchaseOrderDetail; }
            set
            {
                currentPurchaseOrderDetail = value;
                OnPropertyChanged("CurrentPurchaseOrderDetail");
            }
        }

        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }

        #region INotifyPropertyChanged Members

        public event PropertyChangedEventHandler PropertyChanged;

        #endregion
    }

    public class Sale
    {
        public string InvoiceNo { get; set; }
        public string Customer { get; set; }
        public DateTime? InvoiceDate { get; set; }
    }
}
