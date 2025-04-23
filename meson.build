project('pram',
  version: '12',
  license: 'GPL-2.0-or-later',
  meson_version: '>=0.49.0')

install_data('pram',
  install_dir: get_option('bindir'),
  install_mode: 'rwxr-xr-x')
install_man('pram.1')

sh = find_program('sh')
tests = [
  '00basic',
  '01signoff-missing',
  '01signoff-partial',
  '01signoff-present',
  '02bug-number',
  '02bug-url',
  '02closes-number',
  '02closes-url',
  '03bug-multiple',
  '03closes-multiple',
  '03combined-bug-closes',
  '03combined-signoff-bug',
  '04interactive-no',
  '04interactive-yes',
  '05editor-empty',
  '05editor-fail',
  '06gpgsign',
  '10threeway',
  '10threeway-disabled',
  '11combined-partof-signoff-bug',
  '11partof',
]

foreach t : tests
  test(t, sh,
    args: [t + '.sh'],
    workdir: meson.current_source_dir() / 'test')
endforeach
