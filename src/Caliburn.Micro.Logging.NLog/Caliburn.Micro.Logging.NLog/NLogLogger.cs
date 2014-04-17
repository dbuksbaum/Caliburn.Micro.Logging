using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using nlog = NLog;

// ReSharper disable CheckNamespace
namespace Caliburn.Micro.Logging.NLog
// ReSharper restore CheckNamespace
{
  public class NLogLogger : ILog, ILogExtended
  {
    #region Fields
    private readonly nlog.Logger _innerLogger;
    #endregion
    
    #region Constructors
    public NLogLogger(Type type)
    {
      _innerLogger = nlog.LogManager.GetLogger(type.Name);
    }
    #endregion
    
    #region ILog Members
    /// <summary>
    /// Logs the exception.
    /// </summary>
    /// <param name="exception">The exception.</param>
    public void Error(Exception exception)
    {
      _innerLogger.ErrorException(exception.Message, exception);
    }
    /// <summary>
    /// Logs the message as info.
    /// </summary>
    /// <param name="format">A formatted message.</param><param name="args">Parameters to be injected into the formatted message.</param>
    public void Info(string format, params object[] args)
    {
      _innerLogger.Info(format, args);
    }
    /// <summary>
    /// Logs the message as a warning.
    /// </summary>
    /// <param name="format">A formatted message.</param><param name="args">Parameters to be injected into the formatted message.</param>
    public void Warn(string format, params object[] args)
    {
      _innerLogger.Warn(format, args);
    }
    #endregion

    #region Implementation of ILogExtended
    /// <summary>
    /// Logs the message as error.
    /// </summary>
    /// <param name="format">A formatted message.</param>
    /// <param name="args">Parameters to be injected into the formatted message.</param>
    public void Error(string format, params object[] args)
    {
      _innerLogger.Error(format, args);
    }
    /// <summary>
    /// Logs the exception.
    /// </summary>
    /// <param name="exception">The exception.</param>
    /// <param name="format">A formatted message.</param>
    /// <param name="args">Parameters to be injected into the formatted message.</param>
    public void Error(Exception exception, string format, params object[] args)
    {
      _innerLogger.ErrorException(string.Format(format, args), exception);
    }
    #endregion
  }
}
