require 'spec_helper'
require 'neo4j/core/cypher_session/adaptors'

module Neo4j
  module Core
    describe CypherSession::CypherError do
      let(:code) { 'SomeError' }
      let(:message) { 'some fancy error' }
      let(:stack_trace) { "class1:1\nclass2:2\nclass3:3" }
      subject { described_class.new_from(code, message, stack_trace) }

      its(:class) { is_expected.to eq(described_class) }
      its(:inspect) { is_expected.to include(subject.message) }
      its(:message) { is_expected.to include(message, code, stack_trace) }

      its(:original_message) { is_expected.to eq(message) }
      its(:code) { is_expected.to eq(code) }
      its(:stack_trace) { is_expected.to eq(stack_trace) }

      let_context code: 'ConstraintValidationFailed' do
        it { is_expected.to be_a(CypherSession::SchemaErrors::ConstraintValidationFailedError) }
      end

      let_context code: 'ConstraintViolation' do
        it { is_expected.to be_a(CypherSession::SchemaErrors::ConstraintValidationFailedError) }
      end
    end
  end
end
