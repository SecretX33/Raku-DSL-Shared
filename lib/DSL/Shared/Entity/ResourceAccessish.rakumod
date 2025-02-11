use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Utilities::MetaSpecsProcessing;

use Hash::Merge;

role DSL::Shared::Entity::ResourceAccessish {

    ##========================================================
    ## Data
    ##========================================================
    has Hash %!nameToEntityID{Str} = %();
    has Set %!knownNames{Str} = %();
    has Set %!knownNameWords{Str} = %();
    has Int $!numberOfMakeCalls = 0;

    method getNameToEntityID( --> Hash) { %!nameToEntityID }
    method getKnownNames( --> Hash) { %!knownNames }
    method getKnownNameWords( --> Hash) { %!knownNameWords }

    ##========================================================
    ## Ingestion
    ##========================================================
    #| Make the entity name dictionaries.
    method ingest-resource-files($sep is copy = Whatever) {

        if $sep.isa(Whatever) { $sep = ','; }

        #| The function get-resource-files is provided by the classes that do this role.
        my @resourceFileNames = self.get-resource-files();

        #-----------------------------------------------------------
        for @resourceFileNames -> $p {
            my $fileNameKey = $p.key;
            my $slurpable = $p.value;

            my Str @nameIDPairs = $slurpable.lines;

            my %nameRules = @nameIDPairs.map({ $_.split($sep) }).flat;
            %nameRules = %nameRules.keys.map(*.lc) Z=> %nameRules.values;

            self.ingest-entity-dictionary($fileNameKey, %nameRules)
        }

        #-----------------------------------------------------------
        self
    }

    #| Make the entity name dictionaries.
    method ingest-entity-dictionary( Str $class, %nameToIDRules ) {

        my @words = %nameToIDRules.keys.map({ $_.split(/h+/) }).flat;

        if self.getNameToEntityID(){$class}:exists {
            # We cannot just use append because that would produce arrays that are not hashes,
            # hence do not adhere to the type of %!nameToEntityID, etc.
            self.getNameToEntityID(){$class} = merge-hash(self.getNameToEntityID(){$class}, %nameToIDRules);
            self.getKnownNames(){$class} = merge-hash(self.getKnownNames(){$class}, %nameToIDRules).Set;
            self.getKnownNameWords(){$class} = merge-hash(self.getKnownNameWords(){$class}, Set(@words)).Set;
        } else {
            self.getNameToEntityID().append( $class => %nameToIDRules );
            self.getKnownNames().append( $class => Set(%nameToIDRules) );
            self.getKnownNameWords().append( $class => Set(@words) );
        }
    }


    ##========================================================
    ## Access
    ##========================================================
    method is-known-name-word(Str:D $word) {
        my Bool $res = False;
        for self.getKnownNameWords().keys -> $c {
            $res = known-string(self.getKnownNameWords(){$c}, $word, :bool, :!warn);
            last when $res
        }
        $res
    }

    method known-name-word(Str:D $class, Str:D $word, Bool :$bool = True, Bool :$warn = True) {
        known-string(self.getKnownNameWords(){$class}, $word, :$bool, :$warn)
    }

    #-----------------------------------------------------------
    method known-name(Str:D $class, Str:D $phrase, Bool :$bool = True, Bool :$warn = True) {
        known-phrase(self.getKnownNames(){$class}, self.getKnownNameWords(){$class}, $phrase, :$bool, :$warn)
    }

    #-----------------------------------------------------------
    multi method name-to-entity-id(Str:D $phrase, Bool :$warn = False) {
        for self.getNameToEntityID().keys -> $class {
            my $name = self.known-name($class, $phrase, :!bool, :!warn);
            return self.getNameToEntityID{$class}{$name} if $name
        }
    }

    #-----------------------------------------------------------
    multi method name-to-entity-id(Str:D $class, Str:D $phrase, Bool :$warn = False) {
        my $name = self.known-name($class, $phrase.lc, :!bool, :$warn);
        $name ?? self.getNameToEntityID{$class}{$name} !! Nil
    }
}
