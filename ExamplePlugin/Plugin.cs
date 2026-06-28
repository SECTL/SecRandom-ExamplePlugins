using Microsoft.Extensions.Logging;
using SecRandom.Core.Plugins;

namespace SecRandom.ExamplePlugin;

public sealed class Plugin : ISecRandomPlugin
{
    public string Id => "com.example.plugin";

    public void ConfigureServices(IPluginServiceCollection services, IPluginBuildContext context)
    {
        services.AddSettingsPage(new PluginPageRegistration
        {
            PluginId = Id,
            PageId = "plugin.com.example.plugin.settings",
            Name = context.PluginInfo.Manifest.Name,
            IconGlyph = "\uECAA",
            PageType = typeof(ExampleSettingsPage),
            HidePageTitle = true
        });
    }

    public Task OnLoadedAsync(IPluginRuntimeContext context)
    {
        context.Logger.LogInformation("Example plugin loaded. ConfigDirectory={ConfigDirectory}", context.PluginInfo.ConfigDirectory);
        return Task.CompletedTask;
    }
}
