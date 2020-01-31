using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using CashSummaryManager.ViewModels;


namespace CashSummaryManager
{
    /// <summary>
    /// Interaction logic for LogInScreen.xaml
    /// </summary>
    public partial class LogInScreen : Window, INotifyPropertyChanged
    {

        enum Status
        {
            LoginScreen,

            UserOptions
        }
        private Visibility hintVisibility;

        /// <summary>
        /// Creates a new instance of <c>LogOnScreen</c>.
        /// </summary>
        /// 
        Status _status = Status.LoginScreen;

User _user;

        public User User
        {
            get { return _user; }
            set
            {
                if (_user != value)
                {
                    _user = value;

                }
            }
        }

        User _currentUser;

        public User CurrentUser
        {
            get { return _currentUser; }
            set
            {
                if (_currentUser != value)
                {
                    _currentUser = value;
                    OnPropertyChanged("CurrentUser");

                }
            }
        }

        public LogInScreen()
{
    try
    {

        InitializeComponent();

        DataContext = this;
        UserOptionsGrd.DataContext = this;
        HintVisibility = Visibility.Hidden;
        this.Height = 179;
        xUsername.Focus();


        UserOptionsRow.Height = new GridLength(0);


            }
    catch (Exception ex)
    {

        throw ex;
    }
}


        /// <summary>
        /// Successful log on show options...
        /// </summary>
        /// 
        int RowHeight = 169;

        private List<User> _users;


        /// <summary>
        /// Returns the username entered within the UI.
        /// </summary>
        public string UserName
        {
            get { return xUsername.Text; }
        }

        /// <summary>
        /// Returns the password entered within the UI.
        /// </summary>
        public string Password => xPassword.Password;

        private void DoLogonClick(object sender, RoutedEventArgs e)
        {
            DialogResult = true;
             Close();
        }

        public bool HintVisible
        {
            get { return HintVisibility == Visibility.Visible; }
            set
            {
                if (value)
                {
                    HintVisibility = Visibility.Visible;
                }
                else
                {
                    HintVisibility = Visibility.Hidden;
                }
            }
        }

        public Visibility HintVisibility
        {
            get { return hintVisibility; }
            set
            {
                if (value != hintVisibility)
                {
                    this.hintVisibility = value;
                    OnPropertyChanged("HintVisibility");
                }
            }
        }


        #region INotifyPropertyChanged Members

        private event PropertyChangedEventHandler propertyChangedEvent;

        public event PropertyChangedEventHandler PropertyChanged
        {
            add { propertyChangedEvent += value; }
            remove { propertyChangedEvent -= value; }
        }

        protected void OnPropertyChanged(string prop)
        {
            if (propertyChangedEvent != null)
                propertyChangedEvent(this, new PropertyChangedEventArgs(prop));
        }

        #endregion

        private void DoCredentialsFocussed(object sender, RoutedEventArgs e)
        {
            TextBoxBase tb = sender as TextBoxBase;
            if (tb == null)
            {
                PasswordBox pwb = sender as PasswordBox;
                pwb.SelectAll();
            }
            else
            {
                tb.SelectAll();
            }
        }






        private void Continue_Click_1(object sender, RoutedEventArgs e)
        {
            try
            {

                BaseViewModel.Instance.User = User;
               
                Application.Current.ShutdownMode = ShutdownMode.OnExplicitShutdown;

                Application.Current.MainWindow = null;

                this.Close();

                Application.Current.ShutdownMode = ShutdownMode.OnMainWindowClose;
                var shell = new CashSummaryManager.MainWindow();
                shell.Show();

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

       
  


        private void ExitBtn_Click_1(object sender, RoutedEventArgs e)
        {
            App.Current.Shutdown();
        }


        private void UserOptionsBtn_Click(object sender, RoutedEventArgs e)
        {
            if (!App.Authenticate(UserName, Password)) return;
            User = DrawerSelector.Instance.User;
            ShowUserOptions();

        }

        public void ShowUserOptions()
        {
            LoginRow.Height = new GridLength(0);
            UserOptionsRow.Height = new GridLength(RowHeight);
            _status = Status.UserOptions;

            if (User.UserPermissions.Any(x => x.Permission.Name == "Admin"))
            {
                using (var ctx = new CashSummaryDBDataContext())
                {
                    Users = ctx.Users.ToList();
                }
            }


        }

        public List<User> Users
        {
            get => _users;
            set
            {
                _users = value;
                OnPropertyChanged("Users");
            }
        }

        private void BackBtn_Click_1(object sender, RoutedEventArgs e)
        {
            using (var ctx = new CashSummaryDBDataContext())
            {
                var res = ctx.Users.First(x => x.Id == CurrentUser.Id);
                res.LoginName = CurrentUser.LoginName;
                res.Password = CurrentUser.Password;
                ctx.SubmitChanges();
            }
            HideUserOptions();
        }
        public void HideUserOptions()
        {
            LoginRow.Height = new GridLength(RowHeight);
            UserOptionsRow.Height = new GridLength(0);
            _status = Status.LoginScreen;
        }
    }
}
        