export declare class EmergencyService {
    getEmergencyContacts(): Promise<{
        id: string;
        name: string;
        number: string;
        icon: string;
        description: string;
    }[]>;
    getQuickPhrases(language?: string): Promise<{
        id: string;
        phrase: string;
        translation: string;
        pronunciation: string;
    }[] | {
        id: string;
        phrase: string;
        translation: string;
        pronunciation: string;
    }[]>;
    getSafetyTips(): Promise<{
        id: string;
        title: string;
        description: string;
        icon: string;
    }[]>;
    makeEmergencyCall(type: string, location?: string): Promise<{
        message: string;
        type: string;
        location: string;
        timestamp: Date;
        callId: string;
    }>;
}
//# sourceMappingURL=emergency.service.d.ts.map