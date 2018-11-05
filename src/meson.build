inc = include_directories('.')

libsources = [
    'Commands.vala',
    'command/BaseCommand.vala',
    'command/ClosureCommand.vala',
    'interfaces/ICommand.vala',
    'interfaces/ICommandContainer.vala',
    'interfaces/IRequest.vala',
    'interfaces/IUseRequest.vala',
    'requests/BaseRequest.vala'
]

lib = library(
    meson.project_name(),
    libsources,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gio-2.0'),
        dependency('gee-0.8'),
    ],
    version : '0.1',
    install: true,
    install_dir: [true, true, true]
)
