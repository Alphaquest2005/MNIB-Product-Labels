using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Input;
using CashSummaryManager.ViewModels;
using MNIB_Distribution_Manager;

namespace CashSummaryManager
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            Application.Current.DispatcherUnhandledException += Current_DispatcherUnhandledException;
            InitializeComponent();
        }

        private void Current_DispatcherUnhandledException(object sender, System.Windows.Threading.DispatcherUnhandledExceptionEventArgs e)
        {
            var exception = e.Exception;
            do
               if(exception.InnerException != null) exception = exception.InnerException;
            while (exception.InnerException != null);

            MessageBox.Show(exception.Message + "|" + Properties.Settings.Default.CashSummaryConnectionString);
        }

        
        private void MoveWindow(object sender, MouseButtonEventArgs e)
        {
            DragMove();

        }
        private void SwitchWindowState(object sender, MouseButtonEventArgs e)
        {
            if (WindowState == WindowState.Maximized)
            {
                WindowState = WindowState.Normal;
                return;
            }
            if (WindowState == WindowState.Normal)
            {
                WindowState = WindowState.Maximized;

            }
        }
        private void MinimizeWindow(object sender, MouseButtonEventArgs e)
        {
            WindowState = WindowState.Minimized;
        }

        private void CloseWindow(object sender, MouseButtonEventArgs e)
        {
            Application.Current.Shutdown();
           
        }



        private void Grid_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            ReportViewer.Visibility = Visibility.Hidden;
        }


        private void ButtonBase_OnClick(object sender, RoutedEventArgs e)
        {
            ContentControl.Content = CashBreakDown.Instance;
        }

        private void ToDrawerSelector(object sender, RoutedEventArgs e)
        {
            ContentControl.Content = DrawerSelector.Instance;
        }

        private void UpdateRow1(object sender, SelectionChangedEventArgs selectionChangedEventArgs)
        {
            //find this checkbox parent until getting to listitem layer.
            try
            {
                CashBreakDown.Instance.SaveRow((sender as FrameworkElement).DataContext as DrawerCashDetail);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }

        }

        private void AddRow(object sender, RoutedEventArgs e)
        {
            CashBreakDown.Instance.AddRow();
        }

        private void DeleteRow(object sender, RoutedEventArgs e)
        {
            CashBreakDown.Instance.DeleteRow();
        }

        private void SelectCurrentItem(object sender, KeyboardFocusChangedEventArgs e)
        {
            ListViewItem item = (ListViewItem)sender;
            item.IsSelected = true;
        }

        private void SelectCurrentItem(object sender, MouseButtonEventArgs e)
        {
            try
            {
                ListViewItem item = (ListViewItem) sender;
                item.IsSelected = true;
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }

        }


        private void UpdateRow(object sender, RoutedEventArgs e)
        {
            try
            {
                CashBreakDown.Instance.SaveRow((sender as FrameworkElement).DataContext as DrawerCashDetail);
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }

        }

        private void PostSession(object sender, RoutedEventArgs e)
        {
            CashBreakDown.Instance.PostSession();
            ContentControl.Content = CashSummary.Instance;
        }

        private void ToCashBreakDown(object sender, RoutedEventArgs e)
        {
            ContentControl.Content = CashBreakDown.Instance;
        }

        private void NextDrawer(object sender, RoutedEventArgs e)
        {
            ContentControl.Content = DrawerSelector.Instance;
        }

        private void PrintCashSummary(object sender, RoutedEventArgs e)
        {
            FrameworkElement dependencyObject = (FrameworkElement)((FrameworkElement)sender).FindName("CashSummaryGrd");
            PrintClass.Print(ref dependencyObject);
        }

        private void RefreshList(object sender, RoutedEventArgs e)
        {
            
           // CashBreakDown.Instance.RefeshDrawerCashDetails();
              
            
        }


        private void updateDetails(object sender, TextChangedEventArgs e)
        {
            BindingExpression binding = ((FrameworkElement)sender).GetBindingExpression(TextBox.TextProperty);
            binding?.UpdateSource();
        }
    }
}
