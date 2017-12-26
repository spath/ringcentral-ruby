require 'dotenv'
require 'ringcentral'

RSpec.describe 'Fax' do
  describe 'send fax' do
    it 'should send a fax' do
      Dotenv.load
      rc = RingCentral.new(ENV['appKey'], ENV['appSecret'], ENV['server'])
      rc.authorize(username: ENV['username'], extension: ENV['extension'], password: ENV['password'])

      r = rc.post('/restapi/v1.0/account/~/extension/~/fax',
        payload: { to: 16506417402 },
        files:[{ path: './spec/test.png', content_type: 'image/png' }]
      )
      expect(r).not_to be_nil
      message = JSON.parse(r.body)
      expect('Fax').to eq(message['type'])
    end
  end
end
