class StatisticsApi < BaseApi
  version     1
  base_uri    Figaro.env.statistics_api_base_url
  digest_auth Settings.app_name_key, Figaro.env.statistics_api_token

  mapper attributes: { action: :get,  prefix: 'fetch/attributes' },
         users: { action: :get, prefix: 'fetch/users' }
end
