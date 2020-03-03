# acme_application

## Description
An example of a java springboot application deployment cookbook

## Usage
include this cookbook in your cookbook metadata.rb, and then use `acme_application` resource

```
acme_appliation 'my-springboot-app-v1.0.0' do
  artifact_url 'https://my-artifact-store/apps/my-springboot-app-v1.0.0.zip' 
end
```

## Attributes
```
['acme_application']['jre_package']
```
