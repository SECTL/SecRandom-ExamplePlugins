using Avalonia.Controls;

namespace SecRandom.ExamplePlugin;

public sealed class ExampleSettingsPage : UserControl
{
    public ExampleSettingsPage()
    {
        Content = new TextBlock
        {
            Text = "SecRandom Example Plugin",
            Margin = new Avalonia.Thickness(16)
        };
    }
}
