# frozen_string_literal: true

RSpec.describe ZohoSign do
  it "has a version number" do
    expect(ZohoSign::VERSION).not_to be nil
  end

  context "configurable" do
    it "saves the configuration" do
      described_class.config.debug = false
      described_class.config.connection = nil
      described_class.config.oauth.client_id = "1000.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      described_class.config.oauth.client_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      described_class.config.oauth.redirect_uri = "http://example.com"

      described_class.config.update(
        oauth: {
          access_token: "2000.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
          refresh_token: "3000.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        }
      )

      expect(described_class.config.debug).to be_falsey
      expect(described_class.config.connection).to be_nil
      expect(described_class.config.oauth.to_h).to eq({
                                                   client_id: "1000.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                                                   client_secret: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                                                   access_token: "2000.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                                                   refresh_token: "3000.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                                                   redirect_uri: "http://example.com"
                                                 })
      expect(described_class.config.api.to_h).to eq({
                                                 auth_domain: "https://accounts.zoho.com",
                                                 domain: "https://sign.zoho.com",
                                                 base_path: "/api/v1"
                                               })

    end
  end
end
