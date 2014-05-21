using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Windows;
using Caliburn.Micro;
using Caliburn.Micro.Logging;

namespace DebugLoggerSample
{
  /// <summary>
  /// Interaction logic for App.xaml
  /// </summary>
  public partial class App : Application
  {
    static App()
    {
      LogManager.GetLog = type => new DebugLogger(type);
    }
    /// <summary>
    /// Initializes a new instance of the <see cref="T:System.Windows.Application"/> class.
    /// </summary>
    /// <exception cref="T:System.InvalidOperationException">More than one instance of the <see cref="T:System.Windows.Application"/> class is created per <see cref="T:System.AppDomain"/>.</exception>
    public App()
    {
      var log = LogManager.GetLog(GetType());

      log.Info("Hello Caliburn.Micro.Logging World!");
    }
  }
}
