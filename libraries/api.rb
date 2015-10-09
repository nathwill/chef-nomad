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

      def initialize(endpoint = 'http://127.0.0.1:4646')
        uri = URI.parse(endpoint)
        @connection = Net::HTTP.new(uri.host, uri.port)
      end

      def get(path, params = {})
        request_json :get, path, params
      end

      def post(path, params = {})
        request_json :post, path, params
      end

      def put(path, params = {})
        request_json :put, path, params
      end

      def delete(path, params = {})
        request_json :delete, path, params
      end

      private

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

      def request_json(method, path, params)
        response = request(method, path, params)
        OpenStruct.new(code: response.code, body: JSON.parse(response.body))
      rescue JSON::ParserError
        response
      end

      def encoded_params(path, params)
        [path, URI.encode_www_form(params)].join('?')
      end
    end

    def self.jobs(params = {}, client = Nomad::API::Client.new)
      client.get('/v1/jobs', params).body
    end

    def self.nodes(params = {}, client = Nomad::API::Client.new)
      client.get('/v1/nodes', params).body
    end

    def self.allocations(params = {}, client = Nomad::API::Client.new)
      client.get('/v1/allocations', params).body
    end

    def self.allocation(id, params = {}, client = Nomad::API::Client.new)
      client.get("/v1/allocation/#{id}", params).body
    end

    def self.evaluations(params = {}, client = Nomad::API::Client.new)
      client.get('/v1/evaluations', params).body
    end

    def self.leader(params = {}, client = Nomad::API::Client.new)
      client.get('/v1/status/leader', params).body
    end

    def self.peers(params = {}, client = Nomad::API::Client.new)
      client.get('/v1/status/leader', params).body
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
          "/v1/job/#{@name}", params
        ).body
      end

      def save(_params = {})
        fail NotImplementedError
      end

      def update(_params = {})
        fail NotImplementedError
      end

      def delete(params = {})
        @client.delete("/v1/job/#{@name}", params)
      end

      def allocations(params = {})
        @client.get("/v1/job/#{@name}/allocations", params).body
      end

      def evaluate(params = {})
        @client.put("/v1/job/#{@name}/evaluate", params).body
      end

      def evaluations(params = {})
        @client.get("/v1/job/#{@name}/evaluations", params).body
      end
    end

    class Node
      attr_reader :name, :client
      attr_writer :data

      def initialize(id, client = Nomad::API::Client.new, data = nil)
        @id = id
        @client = client
        @data = data
      end

      def data(params = {})
        @data ||= @client.get(
          "/v1/node/#{@id}", params
        ).body
      end

      def allocations(params = {})
        @client.get("/v1/node/#{@id}/allocations", params).body
      end

      def evaluate(params = {})
        @client.put("/v1/node/#{@id}/evaluate", params).body
      end

      def drain(params = { enable: true })
        @client.put("/v1/node/#{@id}/drain", params).body
      end
    end

    module Evaluation
      def self.allocations(id, params = {}, client = Nomad::API::Client.new)
        client.get("/v1/evaluation/#{id}/allocations", params).body
      end
    end

    class Agent
      attr_reader :client
      attr_writer :data

      def initialize(client = Nomad::API::Client.new)
        @client = client
      end

      def data
        @data ||= @client.get('/v1/agent/self').body
      end

      def join(address)
        @client.put('/v1/agent/join', address: address).body
      end

      def members
        @client.get('/v1/agent/members').body
      end

      def force_leave(node)
        @client.put('/v1/agent/force-leave', node: node).code == 200
      end

      def servers
        @client.get('/v1/agent/servers').body
      end

      def update_servers(servers)
        @client.put('/v1/agent/servers', address: servers).code == 200
      end
    end
  end
end
