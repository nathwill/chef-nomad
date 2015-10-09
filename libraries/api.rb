#
# Cookbook Name:: nomad
# Library:: Nomad::Helpers
#
# Copyright 2015 The Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# NomadAPI::Client inspired by Dan Knox
# ref: http://danknox.github.io/2013/01/27/using-rubys-native-nethttp-library/
#
require 'net/http'
require 'ostruct'
require 'json'
require 'uri'

module Nomad
  module API
    class Client
      VERB_MAP ||= {
        get: Net::HTTP::Get,
        post: Net::HTTP::Post,
        put: Net::HTTP::Put,
        delete: Net::HTTP::Delete
      }

      attr_accessor :config, :uri_base

      def initialize(endpoint = 'http://127.0.0.1:4646', config = { version: 1 })
        uri = URI.parse(endpoint)
        @connection = Net::HTTP.new(uri.host, uri.port)
        @config = config
      end

      def get(path, params)
        request_json :get, path, params
      end

      def post(path, params)
        request_json :post, path, params
      end

      def put(path, params)
        request_json :put, path, params
      end

      def delete(path, params)
        request_json :delete, path, params
      end

      def request(method, path, params = {})
        case method
        when :get
          full_path = encoded_params(path, params)
          request = VERB_MAP[method.to_sym].new(full_path)
        else
          request = VERB_MAP[method.to_sym].new(path)
          request.set_form_data(params)
        end

        @connection.request(request)
      end

      private

      def request_json(method, path, params)
        response = request(method, path, params)
        OpenStruct.new(code: response.code, body: JSON.parse(response.body))
      end

      def encoded_params(path, params)
        [path, URI.encode_www_form(params)].join('?')
      end
    end

    def self.jobs(params = {}, client = Nomad::API::Client.new)
      client.get("/v#{client.config[:version]}/jobs", params).body
    end

    def self.nodes(params = {}, client = Nomad::API::Client.new)
      client.get("/v#{client.config[:version]}/nodes", params).body
    end

    def self.allocations(params = {}, client = Nomad::API::Client.new)
      client.get("/v#{client.config[:version]}/allocations", params).body
    end

    def self.evaluations(params = {}, client = Nomad::API::Client.new)
      client.get("/v#{client.config[:version]}/evaluations", params).body
    end

    def self.leader(params = {}, client = Nomad::API::Client.new)
      client.request(
        :get, "/v#{client.config[:version]}/status/leader", params
      ).body
    end

    def self.peers(params = {}, client = Nomad::API::Client.new)
      client.get("/v#{client.config[:version]}/status/leader", params).body
    end

    class Job
      attr_reader :name, :client
      attr_writer :data
      def initialize(name, client = Nomad::API::Client.new, data = nil)
        @name = name
        @client = client
        @data = data
      end

      def data(params = {})
        @data ||= @client.get(
          "/v#{@client.config[:version]}/job/#{@name}", params
        ).body
      end

      def save(params = {})
        @client.put("/v#{@client.config[:version]}/job/#{@name}", @data.merge(params))
      end

      def update(params = {})
        @client.post("/v#{@client.config[:version]}/job/#{@name}", @data.merge(params))
      end

      def delete(params = {})
        @client.delete("/v#{@client.config[:version]}/job/#{@name}", params)
      end

      def allocations(params = {})
        @client.get("/v#{@client.config[:version]}/job/#{@name}/allocations", params).body
      end

      def evaluate(params = {})
        @client.put("/v#{@client.config[:version]}/job/#{@name}/evaluate", params).body
      end

      def evaluations(params = {})
        @client.get("/v#{@client.config[:version]}/job/#{@name}/evaluations", params).body
      end
    end
  end
end
