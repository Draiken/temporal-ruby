require 'temporal/connection/serializer/base'

module Temporal
  module Connection
    module Serializer
      class RetryPolicy < Base
        def to_proto
          return unless object

          non_retriable_errors = Array(object.non_retriable_errors).map(&:name)
          options = {
            initial_interval: object.interval,
            backoff_coefficient: object.backoff,
            maximum_interval: object.max_interval,
            maximum_attempts: object.max_attempts,
            non_retryable_error_types: non_retriable_errors,
          }.compact

          Temporal::Api::Common::V1::RetryPolicy.new(options)
        end
      end
    end
  end
end
