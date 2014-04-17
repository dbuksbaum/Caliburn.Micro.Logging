using System;

// ReSharper disable CheckNamespace

namespace Caliburn.Micro.Logging
// ReSharper restore CheckNamespace
{
  /// <summary>
  /// Extension to the ILog interface to allow for richer Error messages.
  /// Based on a discussion in the Caliburn.Micro discussion forum on Codeplex.
  /// See <see cref="http://caliburnmicro.codeplex.com/discussions/261656"/>.
  /// </summary>
  public interface ILogExtended : ILog
  {
    /// <summary>
    /// Logs the message as error.
    /// </summary>
    /// <param name="format">A formatted message.</param>
    /// <param name="args">Parameters to be injected into the formatted message.</param>
    void Error(string format, params object[] args);
    /// <summary>
    /// Logs the exception.
    /// </summary>
    /// <param name="exception">The exception.</param>
    /// <param name="format">A formatted message.</param>
    /// <param name="args">Parameters to be injected into the formatted message.</param>
    void Error(Exception exception, string format, params object[] args);
  }
}