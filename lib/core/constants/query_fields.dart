const tableNameAuth = 'users';
const queryFieldsFromAuth = '''
  *,
  type_user(*),
  tokens(*),
  img_user(*)
''';
