extends Button


func _on_ReportBugButton_pressed():
	OS.shell_open("https://github.com/GNamimates/gnamimates.github.io/issues/new?assignees=&labels=bug&template=bug_report.md")
