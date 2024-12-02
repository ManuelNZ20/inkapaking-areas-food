const tableNameAuth = 'users';
const queryFieldsFromAuth = '''
  id,
  name,
  last_name,
  gender,
  phone,
  direction,
  state_account,
  email,
  password,
  created_at,
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
  img_user(id,url,created_at)
''';
