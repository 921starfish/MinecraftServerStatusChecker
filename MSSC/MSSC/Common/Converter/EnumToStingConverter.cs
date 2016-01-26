using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;
using Xamarin.Forms;

namespace liquid_win_tablet.Common.Converter
{
    
    public abstract class EnumToStingConverter<T> : IValueConverter
    {
        #region *** Virtual Method : EnumToString
        /// <summary>
        /// Enumを文字列にする
        /// </summary>
        /// <param name="e">T</param>
        /// <returns>string</returns>
        protected virtual string EnumToString(T e)
        {
            return e.ToString();
        }
        #endregion

        #region **** Method : Convert
        /// <summary>
        /// T -> string
        /// </summary>
        /// <param name="value">object</param>
        /// <param name="targetType">Type</param>
        /// <param name="parameter">object</param>
        /// <param name="culture">CultureInfo</param>
        /// <returns>object</returns>
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return EnumToString((T)value);
        }
        #endregion

        #region **** Method : ConvertBack
        /// <summary>
        /// string -> T
        /// </summary>
        /// <param name="value">object</param>
        /// <param name="targetType">Type</param>
        /// <param name="parameter">object</param>
        /// <param name="culture">CultureInfo</param>
        /// <returns>object</returns>
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            foreach (var n in Enum.GetValues(typeof(T)))
            {
                if (EnumToString((T)n) == (string)value)
                    return (T)n;
            }
            throw new ArgumentException();
        }
        #endregion
    }
}
