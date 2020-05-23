namespace :firebase do
  namespace :certificates do
    desc "Request x509 certificates when Redis is empty"
    task :request => :environment do
      FirebaseIdToken::Certificates.request
    end

    desc "Force request x509 certificates and store in Redis"
    task :force_request => :environment do
      FirebaseIdToken::Certificates.request!
    end
  end
end
