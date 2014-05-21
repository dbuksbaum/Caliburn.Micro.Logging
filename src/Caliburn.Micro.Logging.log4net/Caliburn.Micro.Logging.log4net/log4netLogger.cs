using System;
using Log4Net = log4net;

namespace Caliburn.Micro.Logging.log4net
{
  // ReSharper disable InconsistentNaming
  public class log4netLogger : ILogExtended
  // ReSharper restore InconsistentNaming
  {
    #region Fields
    private readonly Log4Net.ILog _innerLogger;
    #endregion

    #region Constructors
    public log4netLogger(Type type)
    {
      _innerLogger = Log4Net.LogManager.GetLogger(type);
    }
    #endregion

    #region ILog Members
    /// <summary>
    /// Logs the exception.
    /// </summary>
    /// <param name="exception">The exception.</param>
    public void Error(Exception exception)
    {
      _innerLogger.Error(exception.Message, exception);
    }
    /// <summary>
    /// Logs the message as info.
    /// </summary>
    /// <param name="format">A formatted message.</param><param name="args">Parameters to be injected into the formatted message.</param>
    public void Info(string format, params object[] args)
    {
      _innerLogger.InfoFormat(format, args);
    }
    /// <summary>
    /// Logs the message as a warning.
    /// </summary>
    /// <param name="format">A formatted message.</param><param name="args">Parameters to be injected into the formatted message.</param>
    public void Warn(string format, params object[] args)
    {
      _innerLogger.WarnFormat(format, args);
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
      _innerLogger.ErrorFormat(format, args);
    }
    /// <summary>
    /// Logs the exception.
    /// </summary>
    /// <param name="exception">The exception.</param>
    /// <param name="format">A formatted message.</param>
    /// <param name="args">Parameters to be injected into the formatted message.</param>
    public void Error(Exception exception, string format, params object[] args)
    {
      _innerLogger.Error(string.Format(format, args), exception);
    }
    #endregion
  }
}