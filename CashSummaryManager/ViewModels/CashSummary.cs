using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows;
using CashSummaryManager.Annotations;

namespace CashSummaryManager.ViewModels
{
    public class CashSummary : INotifyPropertyChanged
    {
        private static readonly CashSummary instance;
        private List<string> _drawerSessionsJournalEntry;
        public static CashSummary Instance => instance;

        static CashSummary()
        {
            instance = new CashSummary();

        }

        public void GetDrawerSessionCashDetails()
        {
            using (var ctx = new CashSummaryDBDataContext())
            {

               
                var res = ctx.DrawSessionDetails
                    .Where(x => x.DrawSessionId == DrawerSelector.Instance.DrawerSession.DrawSessionId).ToList();
                foreach (var s in res)
                {
                    s.CashDetails = ctx.DrawerCashDetails.Where(x => x.DrawSessionId == s.DrawSessionId.ToString() && x.CashTypeComponent.CashType.Name == s.PayCode).ToList();
                }

                DrawSessionDetails = new ObservableCollection<DrawSessionDetail>(res.Where(x => x.CashDetails.Any()).ToList());
                DrawerSessionsJournalEntry = ctx.DrawerSessionsJournalEntries.Where(x =>x.DrawSessionId == DrawerSelector.Instance.DrawerSession.DrawSessionId)
                                            .ToList()
                                            .Select(x => new List<string>()
                    {
                        $@"Debit: {x.DebitAccountNumber}  {x.DebitAccountDescription}  {x.Amount:C}",
                        $@"Credit: {x.CreditAccountNumber}  {x.CreditAccountDescription}  {x.Amount:C}"
                    }).SelectMany(x => x).ToList();
            }
        }

        //public List<string> DebitEntry => $@"Debit: {DrawerSessionsJournalEntry.DebitAccountNumber}  {DrawerSessionsJournalEntry.DebitAccountDescription}  {DrawerSessionsJournalEntry.Amount:C}";
        //public List<string> CreditEntry => $@"Credit: {DrawerSessionsJournalEntry.CreditAccountNumber}  {DrawerSessionsJournalEntry.CreditAccountDescription}  {DrawerSessionsJournalEntry.Amount:C}";

        public ObservableCollection<DrawSessionDetail> DrawSessionDetails { get; set; }

        public List<string> DrawerSessionsJournalEntry
        {
            get => _drawerSessionsJournalEntry;
            private set
            {
                _drawerSessionsJournalEntry = value;
                OnPropertyChanged();
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        [NotifyPropertyChangedInvocator]
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));

        }

       
    }
}