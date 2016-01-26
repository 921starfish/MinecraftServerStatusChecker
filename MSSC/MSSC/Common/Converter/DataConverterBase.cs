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
    /// <summary>
    /// データーコンバーター用の基底クラス
    /// </summary>
    /// <typeparam name="T1">入力値の型</typeparam>
    /// <typeparam name="T2">出力値の型</typeparam>
    public class DataConverterBase<T1, T2> : IValueConverter
    {
        #region **** Delegates

        protected Func<T1, T2> Convert;
        protected Func<T2, T1> ConvertBack;

        #endregion

        #region **** Method : IValueConverter.Convert
        /// <summary>
        /// IValueConverter.Convertの実装
        /// </summary>
        /// <param name="value">object</param>
        /// <param name="targetType">Type</param>
        /// <param name="parameter">object</param>
        /// <param name="culture">CultureInfo</param>
        /// <returns>object</returns>
        object IValueConverter.Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return (Convert != null) ? Convert((T1)value) : value;
        }
        #endregion

        #region **** Method : IValueConverter.ConvertBack
        /// <summary>
        /// IValueConverter.ConvertBackの実装
        /// </summary>
        /// <param name="value">object</param>
        /// <param name="targetType">Type</param>
        /// <param name="parameter">object</param>
        /// <param name="culture">CultureInfo</param>
        /// <returns>object</returns>
        object IValueConverter.ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return (ConvertBack != null) ? ConvertBack((T2)value) : value;
        }
        #endregion
    }
}
