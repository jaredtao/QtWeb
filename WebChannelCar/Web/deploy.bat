@echo off
set targetPath=..\bin\release
if exist %targetPath%\out\ ( rd /s /q %targetPath%\out)
if exist %targetPath%\page\ ( rd /s /q %targetPath%\page)
if exist %targetPath%\style\ ( rd /s /q %targetPath%\style)
if exist %targetPath%\img\ ( rd /s /q %targetPath%\img)
md %targetPath%\out
md %targetPath%\page
md %targetPath%\style
md %targetPath%\img
xcopy /s /q /y page %targetPath%\page
xcopy /s /q /y out %targetPath%\out
xcopy /s /q /y style %targetPath%\style
xcopy /s /q /y img %targetPath%\img
