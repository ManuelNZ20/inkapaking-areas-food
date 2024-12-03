const tableNameAuth = 'users';
const queryFieldsFromAuth = '''
  *,
  type_user_id(
    id,
    type_name,
    description
  ),
  tokens(id_token,
    token_auth,
    token_access,
    state,
    created_at
  ),
  img_user(
  id,
  url,
  created_at
  )
''';
