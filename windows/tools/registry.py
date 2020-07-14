import utils

def register(target):

    # PythonCore entries
    short_version = utils.get_python_infos(target)[0]
    long_version = utils.get_python_long_version(target)
    key_core = (KEY_S1 % short_version) + r'\%s'
    winreg.SetValueEx(
        winreg.CreateKey(root, key_core % 'InstallPath'),
        "",
        0,
        winreg.REG_SZ,
        target,
    )
    winreg.SetValueEx(
        winreg.CreateKey(
            root, key_core % r'InstallPath\InstallGroup'
        ),
        "",
        0,
        winreg.REG_SZ,
        "Python %s" % short_version,
    )
    winreg.SetValueEx(
        winreg.CreateKey(root, key_core % 'Modules'),
        "",
        0,
        winreg.REG_SZ,
        "",
    )
    winreg.SetValueEx(
        winreg.CreateKey(root, key_core % 'PythonPath'),
        "",
        0,
        winreg.REG_SZ,
        r"%s\Lib;%s\DLLs" % (target, target),
    )
    winreg.SetValueEx(
        winreg.CreateKey(
            root,
            key_core % r'Help\Main Python Documentation',
        ),
        "",
        0,
        winreg.REG_SZ,
        r"%s\Doc\python%s.chm" % (target, long_version),
    )